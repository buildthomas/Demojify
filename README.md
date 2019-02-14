# Demojify

A module that provides a function to strip emoji-like codepoints from strings for use in Roblox.

See the file Demojify.lua for the implementation. The module is used like so:

```lua

local demojify = require((...).Demojify)

print(demojify("😂i love emojis ✔ they are #⃣1⃣ wait I gotta go 🚽🚀. EMOJI HYPE ✊"))
--> i love emojis  they are #1 wait I gotta go . EMOJI HYPE
```

Feel free to submit pull requests if you find additional codepoints that should be stripped by this function.
