function hideAddressBar()
{
    window.scrollTo(0, 0);
}

addEventListener('load', function()
{
    setTimeout(hideAddressBar, 0);
}, false);

window.onorientationchange = function()
{
    switch(window.orientation)
    {
        case 0:
        case 180:
            hideAddressBar();
            break;
        case -90:
        case 90:
            hideAddressBar();
            break;
    }
}
