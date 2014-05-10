# Yearbook

A CLI to recognize and crop faces from images using OpenCV. Uses thor and ruby-opencv. Will probably use mini-magick some day.

## Usage

### `find [PATH]`

Detects faces in an image (or glob path) and reports on their position.

`$ yearbook find spec/fixtures/images/washington-george.jpg`

```
spec/fixtures/images/washington-george.jpg  x: 421  y: 968  w: 88 h: 88 px: 7744  neighbors: 9  quality: 7744.09
spec/fixtures/images/washington-george.jpg  x: 421  y: 968  w: 88 h: 88 px: 7744  neighbors: 9  quality: 7744.09  x: 296  y: 256  w: 268  h: 268  px: 71824 neighbors: 86 quality: 71824.86
```

##### Options
- count


### `print [PATH]`

Crops out detected faces in an image, saves them as new files, and returns the path to the cropped out file

`$ yearbook print spec/fixtures/images/washing*.jpg`

```
washington-george.jpg.0296x0256_268x268.jpg
washington-george.jpg.0421x0968_88x88.jpg
```


## Random documentations for now


- [Writing a Thor Application](http://lostechies.com/derickbailey/2011/04/29/writing-a-thor-application/) - a great example of a practical use case and how to keep the code DRY.


## Steps

- Install OpenCV with Homebrew, for instance
  + `brew tap homebrew/science`
  + `brew install opencv`
- Install [ruby-opencv](https://github.com/ruby-opencv/ruby-opencv) Ruby gem
  + `gem install ruby-opencv -- --with-opencv-dir=/usr/local/Cellar/opencv`
- Install [ImageMagick] or [GraphicsMagick] ...not yet actually...
  + `brew install imagemagick`
- Install the [mini-magick](https://github.com/minimagick/minimagick) Ruby gem

blah blah blah

