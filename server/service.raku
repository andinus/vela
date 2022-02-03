use Cro::HTTP::Server;
use Cro::HTTP::Router;
use Cro::HTTP::Log::File;

unit sub MAIN(
    Bool :$debug = True, #= enable debug mode
);

my $application = route {
    post -> 'new' {
        request-body -> (:$name) {

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
