

function DisableScroll() {
  this.keys = [37, 38, 39, 40];
}

DisableScroll.prototype = {
  preventDefault: function(e) {
    e = e || window.event;
    if (e.preventDefault)
      e.preventDefault();
    e.returnValue = false;
  },
  keydown: function(e) {
    for (var i = this.keys.length; i--;) {
      if (e.keyCode === this.keys[i]) {
        this.preventDefault(e);
        return;
      }
    }
  },
  wheel: function(e) {
    this.preventDefault(e);
  },
  disable_scroll: function() {
    if (window.addEventListener) {
      window.addEventListener('DOMMouseScroll', wheel, false);
    }
    window.onmousewheel = document.onmousewheel = wheel;
    document.onkeydown = keydown;
  },
  enable_scroll: function() {
    if (window.removeEventListener) {
      window.removeEventListener('DOMMouseScroll', wheel, false);
    }
    window.onmousewheel = document.onmousewheel = document.onkeydown = null;
  }
};
