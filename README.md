# A FOSS cross-platform "Forest" focus timer alternative built with Godot!

## Contributing Guide-Lines

### Formatting
Just use [Godot's official styling guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#code-order) I Probably don't have everything memorized feel free to help out by just formatting code correctly.

### File Structure
The entirety of The Game's code is inside the /Game Folder; Keep it that way.
The Game Folder contains 5 subfolders:
- Art
- Components
- Resources
- Scenes
- Scripts

We orginize all of our files into these subfolders.
Here's how:
- Art, Icons, Images all get orginized into the Art folder
- Modular Scripts That is to say scripts that are used **Multiple Times** or could be / Scripts that are designed to be generally usable go into the Scripts folder.
- The Scenes folder is used exclusively for a composition of Components and nodes which means we will not have a lot of scenes for this project.
- The Components Folder contains what I like to call components. Components are a tree of nodes: what most people would call a scene but it also contains the Scripts for the component in the same folder. In other words If you make an object It's a component put it in it's own subfolder with it's script(s) together in that folder unless the Script(s) are modular.
