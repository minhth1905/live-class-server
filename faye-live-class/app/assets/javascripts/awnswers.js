PrivatePub.subscribe("/answers/new", function(data, channel) {
  console.log(data);
  var id = "#content_" + data.message.marker_id;
  $(id).html(data.message.content);
});
