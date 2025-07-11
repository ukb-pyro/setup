#!/bin/bash
# setup.sh - Ukubona Recursive Setup Engine (top-down)

set -e  # exit on any error

echo "🌐 Ukubona Recursive Setup Engine"

# --- Prompt for GitHub details ---
read -p "Enter your GitHub username: " GH_USER
read -p "Enter your GitHub personal access token: " GH_TOKEN
read -p "Enter your GitHub repo name: " GH_REPO
read -p "Enter your custom branch name (NOT main): " GH_BRANCH

# Validate branch name
if [[ "$GH_BRANCH" == "main" || ! "$GH_BRANCH" =~ ^[a-zA-Z0-9._/-]+$ ]]; then
  echo "❌ Invalid branch name: '$GH_BRANCH'. Use only letters, numbers, dashes, underscores, or slashes, and not 'main'."
  exit 1
fi

# --- Create project folder ---
mkdir -p "$GH_REPO"
cd "$GH_REPO"

# --- Scaffold project files via origins.py ---
cat << 'EOF' > origins.py
import os

dirs = [
    "fire/static/css",
    "fire/static/js",
    "fire/md",
    "templates"
]

files = {
    "templates/index.jinja2": """<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8' />
  <meta name='viewport' content='width=device-width, initial-scale=1.0' />
  <title>Coen Recursion Engine</title>
  <link rel='stylesheet' href='{{ url_for("static", filename="css/main.css") }}' />
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
  <script src='{{ url_for("static", filename="js/main.js") }}'></script>
</body>
</html>""",

    "fire/static/css/main.css": """body {
  margin: 0;
  padding: 0;
  background: radial-gradient(#000010, #000000);
  overflow: hidden;
  font-family: 'Georgia', serif;
  color: #fff;
}
/* ... add your CSS styling here ... */
""",

    "fire/static/js/main.js": """const glyphs = {
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
});
""",

    "fire/md/README.md": """# Coen Recursion Engine  
A mythic UI simulator grounded in five glyphs: 🌊 ❤️ 🔁 🎭 🤖  
""",

    "app.py": """from flask import Flask, render_template

app = Flask(__name__, static_folder='fire/static', template_folder='templates')

@app.route('/')
def index():
    return render_template('index.jinja2')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
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

echo "🔁 Running origins.py to scaffold project files..."
python3 origins.py

# --- Setup python virtual environment ---
echo "🐍 Creating virtual environment in fire/myenv..."
python3 -m venv fire/myenv

echo "🔄 Activating virtual environment..."
source fire/myenv/bin/activate

# --- Install dependencies ---
echo "📦 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# --- Run Flask app in background ---
echo "🚀 Launching Flask app at http://0.0.0.0:5000 ..."
nohup python3 app.py > flask.log 2>&1 &

# --- Initialize Git, commit, push ---
echo "🔧 Initializing Git repository..."
git init
git checkout -b "$GH_BRANCH"
git add .
git commit -m "🌱 Initial commit from origins.py with virtualenv + Flask app"

echo "🔗 Adding GitHub remote..."
git remote add origin https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/${GH_REPO}.git

echo "⬆️ Pushing to GitHub branch $GH_BRANCH ..."
git push -u origin "$GH_BRANCH"

echo "✅ Setup complete!"
echo "👉 Flask app running: http://0.0.0.0:5000"
        