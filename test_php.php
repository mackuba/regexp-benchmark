<?PHP

$regexps = array(
  '/linux/i', '/debian/i', '/ubuntu/i', '/\bredhat\b/i', '/\bRHEL\b/', '/\bSUSE\b/', '/\bCentOS\b/', '/\bopensuse\b/i',
  '/\bslackware\b/i', '/\bKDE\b/', '/\bGTK\d?\b/', '/#GNOME\b/', '/\bGNOME\s?\d+/', '/\bkde plasma\b/i',
  '/apt\-get/', '/\bflatpak\b/i', '/\b[Xx]org\b/'
);

$posts = file('posts.txt', FILE_IGNORE_NEW_LINES);
$loops = intval($argv[1]);
$matched = 0;

for ($i = 0; $i < $loops; $i++) {
  foreach ($posts as $txt) {
    foreach ($regexps as $r) {
      if (preg_match($r, $txt)) {
        $matched++;
      }
    }
  }
}

echo $matched / $loops;

?>
