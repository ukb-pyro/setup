#!/bin/bash

echo "🌐 Ukubona Recursive Setup Engine"

# Prompt for GitHub credentials
read -p "Enter your GitHub username: " GH_USER
read -p "Enter your GitHub personal access token: " GH_TOKEN    
read -p "Enter your GitHub repo name: " GH_REPO
read -p "Enter your custom branch name (NOT main): " GH_BRANCH

# Validate branch name
if [[ "$GH_BRANCH" == "main" || ! "$GH_BRANCH" =~ ^[a-zA-Z0-9._/-]+$ ]]; then
  echo "❌ Invalid branch name: '$GH_BRANCH'. Use only letters, numbers, dashes, underscores, or slashes."
  exit 1
fi

# Create repo directory and cd in
mkdir -p "$GH_REPO"
cd "$GH_REPO" || exit 1

# Write origins.py
cat << 'EOF' > origins.py
import os

dirs = [
    "fire/css",
    "fire/js",
    "fire/md",
    "fire/myenv"
]

files = {
    "index.html": """<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8' />
  <meta name='viewport' content='width=device-width, initial-scale=1.0' />
  <title>Coen Recursion Engine</title>
  <link rel='stylesheet' href='fire/css/main.css' />
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
  <script src='fire/js/main.js'></script>
</body>
</html>""",

    "fire/css/main.css": """body {
  margin: 0;
  padding: 0;
  background: radial-gradient(#000010, #000000);
  overflow: hidden;
  font-family: 'Georgia', serif;
  color: #fff;
}
/* ... same as before ... */
""",

    "fire/js/main.js": """const glyphs = {
  'glyph-origin': '🌊 Sea (Origins)...',
  'glyph-rules': '❤️ Love (Rules)...',
  'glyph-recursion': '🔁 Recursion (Games)...',
  'glyph-splicing': '🎭 Theater (Splicing)...',
  'glyph-illusion': '🤖 Illusion (Broadcast)...'
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

    "fire/md/README.md": """# Coen Recursion Engine  
A mythic UI simulator grounded in five glyphs: 🌊 ❤️ 🔁 🎭 🤖  
""",

    "app.py": """from flask import Flask, send_from_directory
app = Flask(__name__, static_folder='.')

@app.route('/')
def index():
    return send_from_directory('.', 'index.html')

@app.route('/<path:path>')
def serve_static(path):
    return send_from_directory('.', path)

if __name__ == '__main__':
    app.run(debug=True)
""",

    "requirements.txt": "Flask==3.0.0\n"
}

for d in dirs:
    os.makedirs(d, exist_ok=True)

for path, content in files.items():
    with open(path, 'w') as f:
        f.write(content)

print("✅ Project scaffolded from origins.py")
EOF

# Run origins.py
echo "🔁 Running origins.py..."
python3 origins.py

# Setup Python venv in fire/myenv
echo "🐍 Creating and activating virtual environment in fire/myenv..."
python3 -m venv fire/myenv
source fire/myenv/bin/activate

# Install Flask
echo "📦 Installing dependencies..."
pip install -r requirements.txt

# Run Flask app in background
echo "🚀 Launching Flask app at http://127.0.0.1:5000 ..."
nohup python3 app.py > flask.log 2>&1 &

# Git init and push
echo "🔧 Initializing Git..."
git init
git checkout -b "$GH_BRANCH"
git add .
git commit -m "🌱 Initial commit from origins.py with virtual env + Flask"

echo "🔗 Connecting to GitHub..."
git remote add origin https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/${GH_REPO}.git
git push -u origin "$GH_BRANCH"

echo "✅ Done! Flask app is running. View: http://127.0.0.1:5000"
