# lua-games
Games made with lua 
[Install lua locally](https://www.tutorialspoint.com/lua/lua_quick_guide.htm)

### Readings
[How to make an RPG](https://howtomakeanrpg.com/)

[Game programming patterns](https://gameprogrammingpatterns.com/)

[collisions](https://github.com/noooway/love2d_arkanoid_tutorial)

[particles](https://love2d.org/wiki/ParticleSystem)

[Timer library](https://github.com/airstruck/knife)

[Tilemaps, sprites, etal](https://opengameart.org) --Artist Kenny for sprite sheets

[free music to add to games](https://freemusicarchive.org/genre/Ambient_Electronic?sort=track_date_published&d=1&page=8)

[Make sound effects](https://www.bfxr.net/)

[Box 2d](https://www.iforce2d.net/b2dtut/introduction)

 ### Run a game
Make sure you have [Love2D](https://github.com/love2d/love) installed in your local.
 Cd to the game-parent where there is a `main.lua` and then run `open -n -a love . ` in the terminal
 [Flappy-bird](https://github.com/games50/fifty-bird)
 
 # Mobile Game Development in Unity

## Set-up

* Install Unity remote5
* In unity hub, go to installs and install ios support

[model 3d assets](https://blender.org/)
[Unity docs](https://docs.unity3d.com)
[free icons](https://www.flaticon.com/)
[In depth Unity](https://www.catlikecoding.com/unity/tutorials)
[pictures](https://www.pixabay.com)

### Steps
1. Add canvas and add main camera to it
2. Add gameobjects in the canvas
3. Add rigid body and colliders to the sprites for physics
4. click, hold shift click last image then drag and drop pngs to the heirachy to create animation
5. Add rigibody and collider to sprite
6. Add scripts as new components to the sprites

### Creating particles
* Get the image
* Choose effects, particles in heirachy
* Create material with the sprite

### Sprite alignment
* Put the anchors
* Preserve aspect ratio

Check out Probuilder and Progrids, ShaderGraph in Unity assets
 

## Code analysis with Sonarqube


## Pre-requisites:
* Install [Docker](https://www.docker.com/get-started) for your OS: 
  >**The SonarQube server will be hosted on docker container with a SonarQube base image**
* Install Sonar-scanner
  * Manually install for the appropriate OS [here](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)
  * Use [Homebrew](https://brew.sh/) (***RECOMMENDED***)
      ```
       brew install sonar-scanner
       ```
    >You can **skip the last step** if you do this. A brew install automatically links your binaries and makes it available across your terminal sessions
* Append sonar-scanner bin path to PATH variable in respective run-command file ***(.zshrc, .bashrc, etc)*** 
     ```
       export PATH=$PATH:$HOME/Downloads/sonar-scanner/bin
     ```
  create a `sonar-projects.properties` file with the following info
  ```
    sonar.projectKey=cloud-carbon-footprint-client
    sonar.projectName=cloud-carbon-footprint-client
    sonar.projectVersion=1.0
    sonar.sources=.
    sonar.sourceEncoding=UTF-8
    sonar.web.host=sonarqube
    sonar.typescript.lcov.reportPaths=coverage/lcov.info
    sonar.coverage.exclusions=src/**/*.test.*,src/*.test.*,src/*Config*.*,**/__mocks__/**/*,src/themes/**/*,/src/setupTests.ts
    sonar.web.port=9000
```

## Steps
1. Run SonarQube server
      ```
      docker run -d --name SonarQube -p 9000:9000 -p 9092:9092 sonarqube
      ```
    >**To verify if the container started without errors, run the commands:
`docker ps` or ` docker ps -a` to list even the stopped containers**

1. Now you can visit the Admin UI here: http://localhost:9000.
At first you will be prompted to login. You can find the default credentials are [here](https://docs.sonarqube.org/latest/instance-administration/security/). Initially you will be greeted with an empty dashboard but as you begin scanning the codebase, this dashboard will be populated with two project: the client and the server
1. Before we start scanning, we will need to make some changes in the Admin UI. Given that we are running this locally, there's virtually no need for authentication. `At the top bar, click on Administration > Security then scroll down to "Force User Authentication" and disable it`.
1. Run the test scripts for the projects that you want to analyze. We leverage Jest to generate our test coverage results which is then picked up by the sonar scanner. In order to ensure your coverage is published to the server, you must have run the test script prior to scanning
1. Now we can start scanning! 
    ```
    sonar-scanner
    ```
    >***if you want to scan a single project.***, you will have to run the same script but in the client and server directory respectively. (i.e.`cd server; npm run sonar:scan`)
1. If all goes well, You should be able to see the log trace while scanner is analyzing each file.  **Ensure that you see “EXECUTION SUCCESS” at the end of scanning** for each project (i.e. client, server)
1. Verify the vulnerabilities on the Admin UI http://localhost:9000    

