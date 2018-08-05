This application was made to experiment with Ruby on Rails, image upload/manipulation/moderation, and social media / advertising integration.

It uses AWS S3 for image storage and AWS Rekognition for image moderation. With rekognition the app should not allow explicit images or images that don't contain a dog. There is a small degree of false positives when it comes to rekognition either thinking an image is explicit when it is not or not finding a dog when one is clearly there. For the most part, it works well, but in a "true" production environment it would probably require some tweaking.

The app is hosted on Heroku, and is running on www.lookatthesedogs.com. It may take a moment to respond when first accessed, since it is being hosted on Heroku's free tier and often has to spin up if it has been idle. 
