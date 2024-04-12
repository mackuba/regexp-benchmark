import fs from 'node:fs';
import process from 'node:process';

const regexps = [
  /linux/i, /debian/i, /ubuntu/i, /\bredhat\b/i, /\bRHEL\b/, /\bSUSE\b/, /\bCentOS\b/, /\bopensuse\b/i,
  /\bslackware\b/i, /\bKDE\b/, /\bGTK\d?\b/, /#GNOME\b/, /\bGNOME\s?\d+/, /\bkde plasma\b/i,
  /apt\-get/, /\bflatpak\b/i, /\b[Xx]org\b/
];

const loops = parseInt(process.argv[2]);
let matched = 0;

fs.readFile('posts.txt', 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading file:', err);
    return;
  }

  const posts = data.split('\n');

  for (let i = 0; i < loops; i++) {
    posts.forEach((line) => {
      regexps.forEach((r) => {
        if (r.test(line)) {
          matched++;
        }
      });
    });
  }

  console.log(matched / loops);
});
