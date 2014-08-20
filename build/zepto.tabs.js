(function($) {
  return $.fn.tabs = function(_options) {
    var options;
    options = $.extend({
      headers: '.header>*',
      body: '.body',
      activeClass: 'active',
      hiddenClass: 'hidden',
      animate: true,
      duration: 100,
      startIndex: 0,
      touch: true,
      cycle: false
    }, _options);
    return $(this).each(function() {
      var $body, $bodys, $headers, $this, Init, current_index, len, switchTo, width;
      current_index = options.startIndex;
      $this = $(this);
      $headers = $this.find(options.headers);
      $body = $this.find(options.body);
      $bodys = $body.children();
      len = $headers.length;
      width = $body.width();
      switchTo = function(index) {
        var $new, $old;
        if (index !== current_index) {
          $old = $bodys.eq(current_index);
          $old.css({
            display: 'none'
          }).removeClass(options.activeClass);
          if (options.animate) {
            $old.css({
              opacity: 0
            });
          }
          $headers.eq(current_index).removeClass(options.activeClass);
          current_index = index;
          $new = $bodys.eq(current_index);
          $new.css({
            display: null
          }).addClass(options.activeClass);
          if (options.animate) {
            $new.animate({
              opacity: 1
            }, options.duration, 'ease-out');
          }
          return $headers.eq(current_index).addClass(options.activeClass);
        }
      };
      (Init = function() {
        $headers.eq(current_index).addClass(options.activeClass);
        $bodys.css({
          display: 'none'
        });
        if (options.animate) {
          $bodys.css({
            opacity: 0
          });
        }
        $bodys.eq(current_index).css({
          display: 'block'
        }).addClass(options.activeClass);
        if (options.animate) {
          return $bodys.eq(current_index).css({
            opacity: 1
          });
        }
      })();
      if (options.touch) {
        $headers.tap(function() {
          return switchTo($(this).index());
        });
        if (options.cycle) {
          $body.swipeLeft(function(e) {
            return switchTo((current_index + 1) % len);
          });
          return $body.swipeRight(function(e) {
            return switchTo((current_index - 1) % len);
          });
        } else {
          $body.swipeLeft(function(e) {
            if (current_index + 1 <= len - 1) {
              return switchTo(current_index + 1);
            }
          });
          return $body.swipeRight(function(e) {
            if (current_index - 1 >= 0) {
              return switchTo(current_index - 1);
            }
          });
        }
      } else {
        return $headers.click(function() {
          return switchTo($(this).index());
        });
      }
    });
  };
})(Zepto);
