# Smart image resizer using Image Magick
function resizer() {
    # Usage: resizer input.jpg 360x output.jpg [quality]
    if [ $# -lt 3 ]; then
        echo "Usage: resizer <input> <size> <output> [quality]"
        return 1
    fi

    local input="$1"
    local size="$2"
    local output="$3"
    local quality="${4:-82}" # default

    magick "$input" \
        -strip \
        -thumbnail "$size" \
        -filter Triangle \
        -define filter:support=2 \
        -unsharp 0.25x0.25+8+0.065 \
        -quality "$quality" \
        -define jpeg:fancy-upsampling=off \
        -define png:compression-level=9 \
        -define png:compression-strategy=2 \
        -define png:compression-filter=5 \
        -colorspace sRGB \
        -interlace none \
        "$output"
}

# Adding blurred canvas to image using ImageMagick
function canvasmaker() {
  convert -monitor -size $2x$3 xc:transparent $1 -geometry x$3 -blur 0x30 -brightness-contrast -55x-60 -modulate 100,60 -gravity center -composite $1 -geometry $2 -gravity center -composite  $4
}
function canvasmaker-light() {
  convert -monitor -size $2x$3 xc:transparent $1 -geometry x$3 -blur 0x30 -brightness-contrast 45x55 -modulate 100,60 -gravity center -composite $1 -geometry $2 -gravity center -composite  $4
}

# Generating web icons set
function webicon() {
  if [ $# -eq 0 ]; then
    echo -e "Usage: webicon source.png \[destination\]
Use at least 320px image (512px recommended).\n";
  elif [ $# -eq 1 ]; then
    2=$(dirname "$(realpath $1)")
  fi

  echo "📁 Creating destination folder at $2/icons...";
  mkdir "$2/icons";
  
  echo -e "\n🌄 Creating main favicon...";
  convert $1 -define icon:auto-resize=64,48,32,16 "$2/icons/favicon.ico";
  
  echo -e "\n🌄 Creating 32px PNG favicon...";
  resizer $1 32 "$2/icons/favicon-32.png";
  echo -e "\n🌄 Creating 144px PNG favicon...";
  resizer $1 144 "$2/icons/favicon-144.png";
  echo -e "\n🌄 Creating 196px PNG favicon...";
  resizer $1 196 "$2/icons/favicon-196.png";
  
  echo -e "\n🌄 Creating 192px PNG touch-icon...";
  resizer $1 192 "$2/icons/favicon-192.png";

  echo -e "\n🌄 Creating 57px PNG apple-touch-icon...";
  resizer $1 57 "$2/icons/apple-touch-icon-precomposed.png";
  echo -e "\n🌄 Creating 72px PNG apple-touch-icon...";
  resizer $1 72 "$2/icons/apple-touch-icon-72x72-precomposed.png";
  echo -e "\n🌄 Creating 76px PNG apple-touch-icon...";
  resizer $1 76 "$2/icons/apple-touch-icon-76x76-precomposed.png";
  echo -e "\n🌄 Creating 114px PNG apple-touch-icon...";
  resizer $1 114 "$2/icons/apple-touch-icon-114x114-precomposed.png";
  echo -e "\n🌄 Creating 120px PNG apple-touch-icon...";
  resizer $1 120 "$2/icons/apple-touch-icon-120x120-precomposed.png";
  echo -e "\n🌄 Creating 144px PNG apple-touch-icon...";
  resizer $1 144 "$2/icons/apple-touch-icon-144x144-precomposed.png";
  echo -e "\n🌄 Creating 152px PNG apple-touch-icon...";
  resizer $1 152 "$2/icons/apple-touch-icon-152x152-precomposed.png";
  echo -e "\n🌄 Creating 180px PNG apple-touch-icon...";
  resizer $1 180 "$2/icons/apple-touch-icon-180x180-precomposed.png";

  echo -e "\n🌄 Creating 70px PNG icon-smalltile...";
  resizer $1 70 "$2/icons/icon-smalltile.png";
  echo -e "\n🌄 Creating 150px PNG icon-mediumtile and icon-widetile...";
  resizer $1 150 "$2/icons/icon-mediumtile.png";
  cp "$2/icons/icon-mediumtile.png $2/icons/icon-widetile.png"
  echo -e "\n🌄 Creating 310px PNG icon-largetile...";
  resizer $1 310 "$2/icons/icon-largetile.png";

  echo -e "\n📄 Creating snippets.html...";
  echo "<meta name=\"theme-color\" content=\"#ffffff\"> <!-- change me -->
<link rel=\"icon\" sizes=\"32x32\" href=\"favicon-32.png\">
<link rel=\"icon\" sizes=\"192x192\" href=\"touch-icon-192x192.png\">
<link rel=\"shortcut icon\" sizes=\"196x196\" href=\"favicon-196.png\">
<link rel=\"apple-touch-icon-precomposed\" href=\"apple-touch-icon-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"72x72\" href=\"apple-touch-icon-72x72-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"76x76\" href=\"apple-touch-icon-76x76-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"114x114\" href=\"apple-touch-icon-114x114-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"120x120\" href=\"apple-touch-icon-120x120-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"144x144\" href=\"apple-touch-icon-144x144-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"152x152\" href=\"apple-touch-icon-152x152-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"180x180\" href=\"apple-touch-icon-180x180-precomposed.png\">
<meta name=\"msapplication-TileColor\" content=\"#ffffff\"> <!-- change me -->
<meta name=\"msapplication-TileImage\" content=\"favicon-144.png\">
<meta name=\"application-name\" content=\"Change me, obviously\"> <!-- change me -->
<meta name=\"msapplication-tooltip\" content=\"Change me also\"> <!-- change me -->
<meta name=\"msapplication-config\" content=\"ieconfig.xml\">" > "$2/icons/snippets.html";
  
  echo -e "\n📄 Creating ieconfig.xml...";
  echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
  <browserconfig>
    <msapplication>
      <tile>
        <square70x70logo src=\"smalltile.png\"/>
        <square150x150logo src=\"mediumtile.png\"/>
        <wide310x150logo src=\"widetile.png\"/>
        <square310x310logo src=\"largetile.png\"/>
        <TileColor>#ffffff</TileColor> <!-- change me and remove the comment -->
      </tile>
    </msapplication>
  </browserconfig>" > "$2/icons/ieconfig.xml";

  echo -e "\n🎉 Web icons has been created!

To add the icons to your page, put the icons and the XML file into your public directory,
and add the code on the snippets.html to your template. You might want to change some
meta tags and the config in the snippets.html and ieconfig.xml before use.";
}
