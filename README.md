# BWDebug

A collection of CC0 debug tools by Bramwell Williams.

The Debug panel is a canvas layer you can add to your game world with a selection of tools to aid in your debugging process.

The core of the panel is the observer window. Here you can add groups you want to observe in real time. Their properties are exposed and you can observer them changing in real time. There are other useful tools such as options to reload your scenes and alter the games time scale to observe your properties changing in finer detail.

## How to

### Usage

Add the BWDebugPanel to your game scene, Here you can enter the InputMap action that should open and close the window as an exported variable as well as a list of groups you want the observer to track.

### Styling

Within the common directory you can find the default theme used by the debug panel. This theme is inherited in the margin container of the debug panel.
