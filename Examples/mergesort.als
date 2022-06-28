(Algorit (main)
 ((for main ((var "left1") (var "left2") (var "right1") (var "right2") (var "x") (var "y") (list "a") (list "b") (list "from") (list "to"))
   (
   (sub merge
    ((clearList: "b")
     (setVar:to: "left1" (getLine:ofList: -1 "from"))
     (setVar:to: "right2" (getLine:ofList: -1 "to"))
     (deleteLine:ofList: -1 "from")
     (deleteLine:ofList: -1 "to")
     (setVar:to: "left2" (truncated: (divide:by: (plus:and: (getVar "left1") (getVar "right2")) 2)))
     (setVar:to: "right1" (plus:and: (getVar "left2") 1))
     (setVar:to: "x" (getVar "left1"))
     (doUntil (or:with: (more:than: (getVar "left1") (getVar "left2")) (more:than: (getVar "right1") (getVar "right2")))
      ((doIfElse (less:than: (getLine:ofList: (getVar "left1") "a") (getLine:ofList: (getVar "right1") "a"))
        ((append:toList: (getLine:ofList: (getVar "left1") "a") "b")
         (changeVar:by: "left1" 1))
        ((append:toList: (getLine:ofList: (getVar "right1") "a") "b")
         (changeVar:by: "right1" 1)))))
     (doUntil (more:than: (getVar "left1") (getVar "left2"))
      ((append:toList: (getLine:ofList: (getVar "left1") "a") "b")
       (changeVar:by: "left1" 1)))
     (doUntil (more:than: (getVar "right1") (getVar "right2"))
      ((append:toList: (getLine:ofList: (getVar "right1") "a") "b")
       (changeVar:by: "right1" 1)))
     (setVar:to: "y" "1")
     (doUntil (more:than: (getVar "x") (getVar "right2"))
      ((setLine:ofList:to: (getVar "x") "a" (getLine:ofList: (getVar "y") "b"))
       (changeVar:by: "x" 1)
       (changeVar:by: "y" 1)))))
   
   (sub divide
    ((setVar:to: "left1" (getLine:ofList: (getLine:ofList: 1 "b") "from"))
     (setVar:to: "right2" (getLine:ofList: (getLine:ofList: 1 "b") "to"))
     (deleteLine:ofList: 1 "b")
     (doIf (less:than: (getVar "left1") (getVar "right2"))
      ((setVar:to: "left2" (truncated: (divide:by: (plus:and: (getVar "left1") (getVar "right2")) 2)))
       (setVar:to: "right1" (plus:and: (getVar "left2") 1))
       (doIf (less:than: (getVar "left1") (getVar "left2"))
        ((append:toList: (getVar "left1") "from")
         (append:toList: (getVar "left2") "to")
         (append:toList: (lineCountOfList: "from") "b")))
       (doIf (less:than: (getVar "right1") (getVar "right2"))
        ((append:toList: (getVar "right1") "from")
         (append:toList: (getVar "right2") "to")
         (append:toList: (lineCountOfList: "from") "b")))))))
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 90 10 99 "a")))
   (when start
    ((clearList: "from")
     (clearList: "to")
     (clearList: "b")
     (append:toList: 1 "from")
     (append:toList: (lineCountOfList: "a") "to")
     (append:toList: 1 "b")
     (doUntil (equal:to: (lineCountOfList: "b") "0")
      ((callSubroutine "divide")))
     (doUntil (equal:to: (lineCountOfList: "from") "0")
      ((callSubroutine "merge")))))))))