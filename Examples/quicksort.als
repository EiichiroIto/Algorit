(Algorit (main)
 ((for main ((var "from") (var "oldfrom") (var "oldto") (var "pivot") (var "to") (var "x") (list "fromlist") (list "tolist") (list "a"))
   (
   (sub qsort
    ((setVar:to: "oldfrom" (getVar "from"))
     (setVar:to: "oldto" (getVar "to"))
     (setVar:to: "pivot" (getLine:ofList: (getVar "from") "a"))
     (changeVar:by: "from" 1)
     (doUntil (more:than: (getVar "from") (getVar "to"))
      ((doWhile (and:with: (less:than: (getLine:ofList: (getVar "from") "a") (getVar "pivot")) (less:than: (getVar "from") (getVar "to")))
        ((changeVar:by: "from" 1)))
       (doWhile (and:with: (less:than: (getVar "pivot") (getLine:ofList: (getVar "to") "a")) (lessEqual:than: (getVar "from") (getVar "to")))
        ((changeVar:by: "to" -1)))
       (doIf (equal:to: (getVar "from") (getVar "to"))
        ((swapLine:and:ofList: (getVar "oldfrom") (getVar "from") "a")
         (append:toList: (getVar "oldfrom") "fromlist")
         (append:toList: (minus:with: (getVar "to") 1) "tolist")
         (append:toList: (plus:and: (getVar "from") 1) "fromlist")
         (append:toList: (getVar "oldto") "tolist")
         (doReturn)))
       (doIf (less:than: (getVar "from") (getVar "to"))
        ((swapLine:and:ofList: (getVar "from") (getVar "to") "a")
         (changeVar:by: "from" 1)
         (changeVar:by: "to" -1)))))
     (doIf (more:than: (getVar "from") (getVar "to"))
      ((swapLine:and:ofList: (getVar "oldfrom") (getVar "to") "a")
       (append:toList: (getVar "from") "fromlist")
       (append:toList: (getVar "oldto") "tolist")
       (append:toList: (getVar "oldfrom") "fromlist")
       (append:toList: (minus:with: (getVar "to") 1) "tolist")))))
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 90 10 99 "a")))
   (when start
    ((clearList: "fromlist")
     (clearList: "tolist")
     (append:toList: 1 "fromlist")
     (append:toList: (lineCountOfList: "a") "tolist")
     (doUntil (equal:to: (lineCountOfList: "fromlist") "0")
      ((setVar:to: "from" (getLine:ofList: -1 "fromlist"))
       (setVar:to: "to" (getLine:ofList: -1 "tolist"))
       (deleteLine:ofList: -1 "fromlist")
       (deleteLine:ofList: -1 "tolist")
       (doIf (less:than: (getVar "from") (getVar "to"))
        ((callSubroutine "qsort")))))))))))