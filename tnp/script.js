const images = [
  'images/image1.jpg',
  'images/image2.jpg',
  'images/image3.jpg'
];

let currentIndex = 0;
const sliderImage = document.getElementById('sliderImage');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');

function showImage(index) {
  currentIndex = (index + images.length) % images.length;
  sliderImage.src = images[currentIndex];
}

prevBtn.addEventListener('click', () => {
  showImage(currentIndex - 1);
});

nextBtn.addEventListener('click', () => {
  showImage(currentIndex + 1);
});

showImage(0);
