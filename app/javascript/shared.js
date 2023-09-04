function showToast(message, timeout, type) {
    type = (typeof type === 'undefined') ? 'info' : type;
    toastr.options.timeOut = timeout;
    toastr[type](message);
}
