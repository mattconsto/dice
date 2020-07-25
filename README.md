dice
===

A Jison, DnD-style dice roller. Simply supply a string and it will parse it into a roll. Supports arithmetic, keeping high/low dice, and fudge dice.

## Usage

    npm install fantasy-dice [-g]

    roll 4d6h3

    echo -e "var dice = require('fantasy-dice');\nconsole.log(dice("4d6h3"));" > dice.js
    node dice.js
