#!/bin/bash

echo "🌐 Ukubona Recursive Setup Engine"

# Prompt for GitHub credentials
read -p "Enter your GitHub username: " GH_USER
read -p "Enter your GitHub personal access token: " GH_TOKEN
read -p "Enter your GitHub repo name: " GH_REPO

# Create repo directory if it doesn't exist
mkdir -p $GH_REPO
cd $GH_REPO

# Create origins.py
cat << 'EOF' > origins.py
import os

# Directory tree
dirs = [
    "umubonaboneza/css",
    "umubonaboneza/js",
    "umubonaboneza/md"
]

files = {
    "index.html": """<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8' />
  <meta name='viewport' content='width=device-width, initial-scale=1.0' />
  <title>Coen Recursion Engine</title>
  <link rel='stylesheet' href='umubonaboneza/css/main.css' />
</head>
<body>
  <div class='cosmos'>
    <div id='pentagon'>
      <div class='glyph' id='glyph-origin' data-glyph='🌊'></div>
      <div class='glyph' id='glyph-rules' data-glyph='❤️'></div>
      <div class='glyph' id='glyph-recursion' data-glyph='🔁'></div>
      <div class='glyph' id='glyph-splicing' data-glyph='🎭'></div>
      <div class='glyph' id='glyph-illusion' data-glyph='🤖'></div>
    </div>
    <div id='details' class='hidden'></div>
  </div>
  <script src='umubonaboneza/js/main.js'></script>
</body>
</html>""",

    "umubonaboneza/css/main.css": """body {
  margin: 0;
  padding: 0;
  background: radial-gradient(#000010, #000000);
  overflow: hidden;
  font-family: 'Georgia', serif;
  color: #fff;
}
.cosmos {
  position: relative;
  width: 100vw;
  height: 100vh;
}
#pentagon {
  position: absolute;
  width: 60vmin;
  height: 60vmin;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.glyph {
  position: absolute;
  font-size: 3rem;
  cursor: pointer;
  transition: transform 0.4s ease, text-shadow 0.4s ease;
  animation: pulse 3s infinite;
}
.glyph:hover {
  transform: scale(1.8);
  text-shadow: 0 0 15px #fff, 0 0 30px #fff;
}
#glyph-origin     { top: 0%;   left: 50%; transform: translate(-50%, -50%); }
#glyph-rules      { top: 30%;  left: 90%; transform: translate(-50%, -50%); }
#glyph-recursion  { top: 80%;  left: 70%; transform: translate(-50%, -50%); }
#glyph-splicing   { top: 80%;  left: 30%; transform: translate(-50%, -50%); }
#glyph-illusion   { top: 30%;  left: 10%; transform: translate(-50%, -50%); }
@keyframes pulse {
  0%   { opacity: 0.8; transform: scale(1); }
  50%  { opacity: 1; transform: scale(1.1); }
  100% { opacity: 0.8; transform: scale(1); }
}
#details {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  width: 90%;
  max-height: 40%;
  overflow-y: auto;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.85);
  border: 1px solid #fff;
  border-radius: 1rem;
  font-size: 1rem;
  display: none;
}
#details.visible {
  display: block;
}""",

    "umubonaboneza/js/main.js": """const glyphs = {
  'glyph-origin': \`🌊 Sea (Origins)...\`,
  'glyph-rules': \`❤️ Love (Rules)...\`,
  'glyph-recursion': \`🔁 Recursion (Games)...\`,
  'glyph-splicing': \`🎭 Theater (Splicing)...\`,
  'glyph-illusion': \`🤖 Illusion (Broadcast)...\`
};
document.querySelectorAll('.glyph').forEach(glyph => {
  glyph.innerText = glyph.getAttribute('data-glyph');
  glyph.addEventListener('click', () => {
    const content = glyphs[glyph.id];
    const details = document.getElementById('details');
    details.innerHTML = content;
    details.classList.add('visible');
  });
});""",

    "umubonaboneza/md/README.md": """# Coen Recursion Engine  
A mythic UI simulator grounded in five glyphs: 🌊 ❤️ 🔁 🎭 🤖  
Each glyph opens a narrative based in recursive logic from Coen Brothers' filmography.  
This project renders a cosmic pentagon, alive with animation and responsive to user action.
"""
}

# Create directories
for d in dirs:
    os.makedirs(d, exist_ok=True)

# Write files
for path, content in files.items():
    with open(path, 'w') as f:
        f.write(content)

print("✅ Project scaffolded from origins.py")
EOF

# Run the Python script to generate the project
echo "🔁 Running origins.py..."
python3 origins.py

# Initialize git and push to GitHub
echo "🔧 Initializing git..."
git init
git add .
git commit -m "🌱 Initial commit from origins.py"
git branch -M main

echo "🚀 Pushing to GitHub..."
git remote add origin https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/${GH_REPO}.git
git push -u origin main

echo "✅ All done. Your recursion engine is live."
