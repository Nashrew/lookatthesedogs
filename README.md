This application was made to experiment with Ruby on Rails, image upload/manipulation/moderation, and social media / advertising integration.

It uses AWS S3 for image storage and AWS Rekognition for image moderation. With rekognition the app should not allow explicit images or images that don't contain a dog. There is a small degree of false positives when it comes to rekognition either thinking an image is explicit when it is not or not finding a dog when one is clearly there. For the most part, it works well, but in a "true" production environment it would probably require some tweaking.

This app was previously hosted on Heroku, but the Heroku stack it was on has reached EoL and the app has not been updated yet in order to re-deploy. 
