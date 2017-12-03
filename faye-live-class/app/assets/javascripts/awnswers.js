// PrivatePub.subscribe("/answers/new", function(data, channel) {
//   console.log(data);
//   // var id = "#content_" + data.message.marker_id;
//   // $(id).html(data.message.content);
// });
PrivatePub.subscribe("/next_pages/new", function(data, channel) {
  console.log(data);
  if(data && data.type == "redirect") {
    var arr = data.message.split("_")
    var urls = url + "exams/" + arr[0] + "?type=" + arr[1];
    window.location.replace(urls);
  }

  if(data && data.type == "show_answer") {
    var arr = data.message.split("_")
    var urls = url + "exams/" + arr[0] + "?type=" + arr[1] + '&show_answer=1';
    window.location.replace(urls);
  }

  if(data && data.type == "answer") {
    var id = "#content_" + data.message.student_id + '_' + data.message.question_id;
    var id_2 = "#student_" + data.message.student_id + '_' + data.message.question_id;
    $(id).html("Đã trả lời");
    $(id).css("display", "none");
  }
});
