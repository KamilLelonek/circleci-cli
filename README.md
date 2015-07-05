# CircleCi CLI

CircleCI command line interface based on the [REST API](https://circleci.com/docs/api).

## Setup

1. Create a new CircleCI APItoken on [API Tokens page](https://circleci.com/account/api).
2. Install all dependencies:
    
        mix deps.get
        
## Run

You can run project in two ways. Either you can create an executable program:

	mix escript.build
	
Or run an interactive console and play with the code:

	iex -S mix

## Usage

Each time you execute some command you have to provide CircleCI API token somehow. It can be do in the following ways:

1. Store `CIRCLECI_API_TOKEN` as your system environmental variable so that it can be discoverable.
2. Provide `CIRCLECI_API_TOKEN` each time you are executing the program:

    	CIRCLECI_API_TOKEN=xxxxxxxx circleci [command]
    	
3. Add a corresponding flag when you are providing other commands:

        circleci [command] --token=xxxxxxxx

### Available commands

      -h, --help                                  Displays this help message.
      user                                        Provides information about the signed in user.
      projects                                    List of all the projects you're following on CircleCI, with build information organized by branch.
      builds                                      Build summary for each of the last 30 recent builds, ordered by build number.
      user-key                                    Adds a CircleCI key to your Github User account.
      project     -u USER -p PROJECT              Build summary for each of the last 30 builds for a single git repo.
      build       -u USER -p PROJECT -n BUILD     Full details for a single build. The response includes all of the fields from the build summary.
      artifacts   -u USER -p PROJECT -n BUILD     Lists the artifacts produced by a given build.
      retry       -u USER -p PROJECT -n BUILD     Retries the build, returns a summary of the new build.
      cancel      -u USER -p PROJECT -n BUILD     Cancels the build, returns a summary of the build.
      trigger     -u USER -p PROJECT -b BRANCH    Triggers a new build, returns a summary of the build.
      clear-cache -u USER -p PROJECT              Clears the cache for a project.
      project-key -u USER -p PROJECT              Creates an ssh key used to access external systems that require SSH key-based authentication.
      heroku-key  -k KEY                          Adds your Heroku API key to CircleCI, takes apikey as form param name.

    All flags have abbrevations and they are equivalent:
      -h,       --help
      -t VALUE, --token=VALUE
      -u VALUE, --user=VALUE
      -p VALUE, --project=VALUE
      -n VALUE, --build=VALUE
      -b VALUE, --branch=VALUE
      -k VALUE, --key=VALUE

## Tests

To run all tests do:

    mix test
