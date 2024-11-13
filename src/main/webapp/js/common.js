//문자서비스 탭
$(function(){
    $('.btn_opt').click(function(){
        $(".message_out").hide();
        $('.message_opt').show();
        $('.btn_opt').addClass('on');
        $('.btn_out').removeClass('on');
    })
    $('.btn_out').click(function(){
        $('.message_opt').hide();
        $('.message_out').show();
        $('.btn_opt').removeClass('on');
        $('.btn_out').addClass('on');
    });
});


/*범례*/
$(function(){
    $('.depth01').click(function(){
        $(".depth_cont ul").hide();
        $('.depth01C').css('display','flex');
        $('.legendTab>ul>li').removeClass('active');
        $('.depth01').addClass('active');
    });
    $('.depth02').click(function(){
        $(".depth_cont ul").hide();
        $('.depth02C').css('display','flex');
        $('.legendTab>ul>li').removeClass('active');
        $('.depth02').addClass('active');
    });
    $('.depth03').click(function(){
        $(".depth_cont ul").hide();
        $('.depth03C').css('display','flex');
        $('.legendTab>ul>li').removeClass('active');
        $('.depth03').addClass('active');
    });
    $('.depth04').click(function(){
        $(".depth_cont ul").hide();
        $('.depth04C').css('display','flex');
        $('.legendTab>ul>li').removeClass('active');
        $('.depth04').addClass('active');
    });
    $('.depth05').click(function(){
        $(".depth_cont ul").hide();
        $('.depth05C').css('display','flex');
        $('.legendTab>ul>li').removeClass('active');
        $('.depth05').addClass('active');
    });
    $('.depth06').click(function(){
        $(".depth_cont ul").hide();
        $('.depth06C').css('display','flex');
        $('.legendTab>ul>li').removeClass('active');
        $('.depth06').addClass('active');
    })
    
});

//미세먼지 정보 탭
$(function(){
    $('.btn_info').click(function(){
        $(".behavingCont").hide();
        $('.infoArea').show();
        $('.btn_info').addClass('on');
        $('.btn_beh').removeClass('on');
    })
    $('.btn_beh').click(function(){
        $('.infoArea').hide();
        $('.behavingCont').show();
        $('.btn_info').removeClass('on');
        $('.btn_beh').addClass('on');
    });
});

//미세먼지정보 행동요령 탭
$(function(){
    $('.btn_beh01').click(function(){
        $(".begWrap>div").hide();
        $('.beg01').show();
        $('.tab_wrap02>ul>li').removeClass('on');
        $('.btn_beh01').addClass('on');
    });
    $('.btn_beh02').click(function(){
        $(".begWrap>div").hide();
        $('.beg02').show();
        $('.tab_wrap02>ul>li').removeClass('on');
        $('.btn_beh02').addClass('on');
    })
    $('.btn_beh03').click(function(){
        $(".begWrap>div").hide();
        $('.beg03').show();
        $('.tab_wrap02>ul>li').removeClass('on');
        $('.btn_beh03').addClass('on');
    })
    $('.btn_beh04').click(function(){
        $(".begWrap>div").hide();
        $('.beg04').show();
        $('.tab_wrap02>ul>li').removeClass('on');
        $('.btn_beh04').addClass('on');
    })
    $('.btn_beh05').click(function(){
        $(".begWrap>div").hide();
        $('.beg05').show();
        $('.tab_wrap02>ul>li').removeClass('on');
        $('.btn_beh05').addClass('on');
    })
});

//지도 탭
$(function(){
    $('.btn_today').click(function(){
        $("#yesMap").hide();
        $('#todayMap').show();
        $('.btn_today').addClass('on');
        $('.btn_yes').removeClass('on');
    })
    $('.btn_yes').click(function(){
        $('#todayMap').hide();
        $('#yesMap').show();
        $('.btn_today').removeClass('on');
        $('.btn_yes').addClass('on');
    });
});


//차트 탭
$(function(){
    $('.btn_chart01').click(function(){
        $(".chartWrap>div").hide();
        $('.chart01').show();
        $('.chartTab>ul>li').removeClass('on');
        $('.btn_chart01').addClass('on');
    });
    $('.btn_chart02').click(function(){
        $(".chartWrap>div").hide();
        $('.chart02').show();
        $('.chartTab>ul>li').removeClass('on');
        $('.btn_chart02').addClass('on');
    });
    $('.btn_chart03').click(function(){
        $(".chartWrap>div").hide();
        $('.chart03').show();
        $('.chartTab>ul>li').removeClass('on');
        $('.btn_chart03').addClass('on');
    });
    $('.btn_chart04').click(function(){
        $(".chartWrap>div").hide();
        $('.chart04').show();
        $('.chartTab>ul>li').removeClass('on');
        $('.btn_chart04').addClass('on');
    });
    $('.btn_chart05').click(function(){
        $(".chartWrap>div").hide();
        $('.chart05').show();
        $('.chartTab>ul>li').removeClass('on');
        $('.btn_chart05').addClass('on');
    });
    $('.btn_chart06').click(function(){
        $(".chartWrap>div").hide();
        $('.chart06').show();
        $('.chartTab>ul>li').removeClass('on');
        $('.btn_chart06').addClass('on');
    });
});

//시각화자료 탭
$(function(){
    $('.btn_vchart01').click(function(){
        $(".visChart_wrap>div").hide();
        $('.visChart01').show();
        $('.visTab>ul>li').removeClass('on');
        $('.btn_vchart01').addClass('on');
    });
    $('.btn_vchart02').click(function(){
        $(".visChart_wrap>div").hide();
        $('.visChart02').show();
        $('.visTab>ul>li').removeClass('on');
        $('.btn_vchart02').addClass('on');
    });
    $('.btn_vchart03').click(function(){
        $(".visChart_wrap>div").hide();
        $('.visChart03').show();
        $('.visTab>ul>li').removeClass('on');
        $('.btn_vchart03').addClass('on');
    });
    $('.btn_vchart04').click(function(){
        $(".visChart_wrap>div").hide();
        $('.visChart04').show();
        $('.visTab>ul>li').removeClass('on');
        $('.btn_vchart04').addClass('on');
    });
    $('.btn_vchart05').click(function(){
        $(".visChart_wrap>div").hide();
        $('.visChart05').show();
        $('.visTab>ul>li').removeClass('on');
        $('.btn_vchart05').addClass('on');
    });
});
