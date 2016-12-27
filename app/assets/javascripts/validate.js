 jQuery(document).ready(function() {

  var contract_validator =  $("#image_form").validate({
        submitHandler: function(form) {
          form.submit();
        },
        rules: {
          image_url: {
            required: true,
            url: true
          },
        },
        messages: {
          image_url: {
            required: "Image url can't be blank",
            url: "Please enter a valid url for the image"
          },
        }

    });

  });

