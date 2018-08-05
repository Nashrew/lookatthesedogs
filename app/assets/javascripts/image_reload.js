var onReady = function(){
    try {
        $("#dog_img").click(function(evt){
            window.location.href = "/dogs/random";
        });
        
        $(".btn-facebook").click(function() {
            shareToFacebook();
        });
        
        $(".btn-twitter").click(function() {
            shareToTwitter();
        });
        
        $(window).resize(function() {
            resizeImage($("#dog_img"));
        });
        
        var dogImg = $('#dog_img');
        if(dogImg[0].complete) {
            resizeImage(dogImg);
            dogImg.show();
        }
        else {
            dogImg.one('load', function() { 
                resizeImage($(this)); 
                $(this).show();
            });   
        }
    }
    catch(e) {
        console.log(e);
    }
}

$(document).on('turbolinks:load', onReady);
 
$(document).ajaxSend(function(event, request, settings) {
  $('#dog_img').addClass('loading');
});

function shareToFacebook()
{
    window.open("https://www.facebook.com/sharer/sharer.php?u=http://www.lookatthesedogs.com/dogs/" + $('#dog_img').data('id'), "pop", "width=600, height=400, scrollbars=no");
}

function shareToTwitter()
{
    window.open("http://twitter.com/home?status=Look at this doggo :D http://www.lookatthesedogs.com/dogs/" + $('#dog_img').data('id'), "_blank");
}

function resizeImage(image) {
    
        var $viewPort = $('#main');
        
        var viewporthWidth = $viewPort.width();
        var viewporthHeight = $viewPort.height();
        var imageWidth = image.prop('naturalWidth');
        var imageHeight = image.prop('naturalHeight');
        var aspectRatio = imageWidth / imageHeight;
        var padding = .1;
        
        var tooTall = imageHeight > viewporthHeight;
        var tooWide = imageWidth > viewporthWidth;
        
        if(tooWide && tooTall)
        {
            if((imageWidth / viewporthWidth) > (imageHeight / viewporthHeight))
            {
                adaptedWidth = (1.0 - padding) * viewporthWidth;
                adaptedHeight = adaptedWidth / aspectRatio;
            }
            else
            {
                adaptedHeight = (1.0 - padding) * viewporthHeight;
                adaptedWidth = adaptedHeight * aspectRatio;
            }
        }
        else if(tooWide)
        {
            adaptedWidth = (1.0 - padding) * viewporthWidth;
            adaptedHeight = adaptedWidth / aspectRatio;
        }
        else if(tooTall)
        {
            adaptedHeight = (1.0 - padding) * viewporthHeight;
            adaptedWidth = adaptedHeight * aspectRatio;
        }
        else
        {
            adaptedWidth = imageWidth;
            adaptedHeight = imageHeight;
        }
        
        image.width(adaptedWidth);
        image.height(adaptedHeight);
        $('.center-button').width(adaptedWidth);
}