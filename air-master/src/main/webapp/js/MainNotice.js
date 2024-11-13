/*let title = document.querySelector('#noticeTitle');
let date = document.querySelector('#noticedate');*/
let num = [];
let title = [];
let date = [];

function mainNotice() {
    $.ajax({
        url: "../MainNotice",
        type: "post",
        data: {},
        dataType: "json",
        success: function (data) {
            var noticeList = data.list;

            for (let i = 0; i < 4; i++) {
                var add = "<ul>";
                add += "<li class='listNum'>" + noticeList[i].num + "</li>"; //num
                add += "<li class='listTit'><a href='./detail.notice?num=" + noticeList[i].num + "'>" + noticeList[i].title + "</a></li>"; //title
                add += "<li class='listDate'>" + noticeList[i].date + "</li>"; // date
                add += "</ul>";
                $("#noticeTable").append(add);
                console.log(noticeList[i].title + noticeList[i].date);
            }

        },

        error: function () {
            alert("공지사항 미리보기 실패.");
        }
    });
};




