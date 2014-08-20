(($) ->
  $.fn.tabs = (_options) ->
    options = $.extend
      headers: '.header>*'
      body: '.body'
      activeClass: 'active'
      hiddenClass: 'hidden'
      animate: true
      duration: 100
      startIndex: 0
      touch: true
      cycle: false
    , _options

    $(this).each ->
      current_index = options.startIndex

      $this = $ this
      $headers = $this.find options.headers
      $body = $this.find options.body
      $bodys = $body.children()

      len = $headers.length
      width = $body.width()

      switchTo = (index) ->
        if index != current_index
          $old = $bodys.eq current_index
          $old
            .css {display: 'none'}
            .removeClass options.activeClass
          if options.animate
            $old
              .css {opacity: 0}
          $headers.eq(current_index).removeClass options.activeClass

          current_index = index

          $new = $bodys.eq current_index
          $new
            .css {display: null}
            .addClass options.activeClass
          if options.animate
            $new
              .animate {opacity: 1}, options.duration, 'ease-out'
          $headers.eq(current_index).addClass options.activeClass

      do Init = ->
        $headers.eq current_index
          .addClass options.activeClass

        $bodys.css {display: 'none'}
        if options.animate
          $bodys
            .css {opacity: 0}

        $bodys.eq current_index
          .css {display: 'block'}
          .addClass options.activeClass
        if options.animate
          $bodys.eq current_index
            .css {opacity: 1}

      if options.touch
        $headers.tap ->
          switchTo $(this).index()

        if options.cycle
          $body.swipeLeft (e) ->
            switchTo (current_index + 1) % len

          $body.swipeRight (e) ->
            switchTo (current_index - 1) % len
        else
          $body.swipeLeft (e) ->
            switchTo (current_index + 1) if current_index + 1 <= len - 1

          $body.swipeRight (e) ->
            switchTo (current_index - 1) if current_index - 1 >= 0
      else
        $headers.click ->
          switchTo $(this).index()
) Zepto
