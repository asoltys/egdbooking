var previous_value = '';

Event.observe(window, 'load', function() {

  $$('img.calendar').each(function(e) {
    e.previous().observe('focus', function(e) {
      previous_value = e.element().getValue();
    });

    e.observe('click', function(e) {
      previous_value = e.element().previous().getValue();
      displayDatePicker(e.element().previous());
    });
  });
});

function createObject()
{
  var xmlHttp=null;
  try
  {
  // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
  }
  catch (e)
  {
  // Internet Explorer
    try
    {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e)
     {
      xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
     }
  }
  return xmlHttp;
}

function startLoading()
{
  $('loading').style.display = 'block';

}

function stopLoading()
{
  $('loading').style.display = 'none';
}

/* ---------------------------------------------------------------------------------- getURLparam
 *
 * Description: Takes in the name of a URL parameter and returns the value
 *
 * ----------------------------------------------------------------------------------------------
 */

function getURLparam( key )
{
  key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = key + "=[^&##]*";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results === null ) {
    return "";
  } else {
    return results[1];
  }
}

/* ---------------------------------------------------------------------------------- setURLparam
 *
 * Description: Takes in the name of a URL parameter and sets it to the given value
 *
 * ----------------------------------------------------------------------------------------------
 */

function setURLparam(key, value, old_location)
{
  var new_location;

  if (!old_location) {
    old_location =  window.location.href;
  }

  if (getURLparam(key) != "") {
    var regexS = key + "=([^&##]*)"
    var regex = new RegExp( regexS );
    new_location = old_location.replace(regex, key + "=" + value);
  } else {
    var url_string = /[^##]*/.exec(old_location);
    var anchor_string = /##.*/.exec(old_location);

    if (/\?/.test(url_string)) {
      new_location = url_string + "&" + key + "=" + value;
    } else {
      new_location = url_string + "?" + key + "=" + value;
    }

    if (anchor_string) {
      new_location = new_location + anchor_string;
    }
  }
  return new_location;
}

/* ---------------------------------------------------------------------------------------- fmt00
 *
 * Description: Tags a leading 0 onto single digit numbers.  Used for displaying days and months
 *              for date fields.
 *
 * ----------------------------------------------------------------------------------------------
 */

function fmt00(number) {
  if (parseInt(number) < 0) var neg = true;
  if (Math.abs(parseInt(number)) < 10) {
    number = "0"+ Math.abs(number);
  }
  if (neg) { number = "-"+number };
  return number;
}