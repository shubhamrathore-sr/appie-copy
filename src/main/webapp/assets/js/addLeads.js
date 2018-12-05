$('.tab').on('click', function () {
    $(this).addClass('active');
    $(this).siblings('a').removeClass('active');

    let target = $(this).attr('rel');
    $("#" + target).show().siblings('div').hide();
})

$('.next').on('click', function () {
    let target = $(this).attr('rel');

    $('.' + target + "-tab").addClass('active');
    $('.' + target + "-tab").siblings('a').removeClass('active');

    $("#" + target).show().siblings('div').hide();
})