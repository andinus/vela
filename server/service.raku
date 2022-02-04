use Cro::HTTP::Server;
use Cro::HTTP::Router;
use Cro::HTTP::Log::File;

unit sub MAIN(
    Bool :$debug = True, #= enable debug mode
);

my IO() $store = "store";
mkdir $store;
die "Store doesn't exist" unless $store.d;

my $application = route {
    post -> 'create' {
        request-body -> (:$name) {
            my Str $id = ('a'...'z', 'A'...'Z', 0...9).roll(32).join;
            my Str $auth = ('a'...'z', 'A'...'Z', 0...9).roll(32).join;

            my IO() $user-store = "%s/%s".sprintf: $store, $id;
            mkdir $user-store;
            mkdir "$user-store/images";
            die "Failed to create user store" unless $user-store.d;
            spurt "$user-store/name", "$name";
            spurt "$user-store/auth", "$auth";

            content 'application/json', %(:$id, :$auth);
        }
    }

    post -> 'verify' {
        request-body -> (:$id, :$auth) {
            my IO() $user-store = "%s/%s".sprintf: $store, $id;

            my %res;
            if $user-store.d {
                if "$user-store/auth".IO.slurp ne $auth {
                    response.status = 401;
                } else {
                    %res<name> = "$user-store/name".IO.slurp;
                }
            } else {
                response.status = 404;
            }

            content 'application/json', %res;
        }
    }

    post -> 'upload' {
        request-body -> (:$id is copy, :$auth is copy, :$images) {
            $id .= body-text;
            $auth .= body-text;

            my Bool $skip-loop;
            my IO() $user-store = "%s/%s".sprintf: $store, $id;
            if "$user-store/auth".IO.slurp ne $auth {
                response.status = 401;
                $skip-loop = True;
            }

            my @res;
            IMAGE: for @($images) -> $img {
                last IMAGE if $skip-loop;

                my Bool $stored = True;

                my Str @messages;
                @messages.push("Max file size exceeded")
                    if $img.body-blob.bytes > 2097152; # 1024 * 1024 * 2
                @messages.push("Only png/jpeg allowed");
                    if $img.content-type ne "image/png"|"image/jpeg";

                $stored = False if @messages.elems;
                if $stored {
                    my Str $filename = ('a'...'z', 'A'...'Z', 0...9).roll(16).join;
                    spurt "$user-store/images/$filename", $img.body-blob;
                }

                push @res, %(
                    filename => $img.filename,
                    :@messages, :$stored
                );
            }

            content 'application/json', @res;
        }
    }

    # Serving static assets.
    get -> 'js', *@path { static 'dist/js', @path; }
    get -> 'css', *@path { static 'dist/css', @path; }
    get -> 'img', *@path { static 'dist/img', @path; }
    get -> 'fonts', *@path { static 'dist/fonts', @path; }

    # Serve the app on all paths, it'll handle the routing.
    get -> *@path {
        static 'dist/index.html';
    }
};

my $host = "0.0.0.0";
my $port = 9090;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => $host,
    port => $port,
    :$application,
    after => [
              Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
          ]
);
$http.start;
put "Listening at http://{$host}:{$port}";

react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
