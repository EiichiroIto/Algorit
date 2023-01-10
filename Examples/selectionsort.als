(Algorit (main)
 ((for main ((var "i") (var "j") (var "x") (var "y") (list "a"))
   (
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 20 10 99 "a")))
   (when start
    ((setVar:to: "i" "1")
     (doUntil (equal:to: (getVar "i") (lineCountOfList: "a"))
      ((setVar:to: "j" (plus:and: (getVar "i") 1))
       (doUntil (more:than: (getVar "j") (lineCountOfList: "a"))
        ((setVar:to: "x" (getLine:ofList: (getVar "i") "a"))
         (setVar:to: "y" (getLine:ofList: (getVar "j") "a"))
         (doIf (more:than: (getVar "x") (getVar "y"))
          ((swapLine:and:ofList: (getVar "i") (getVar "j") "a")))
         (changeVar:by: "j" 1)))
       (changeVar:by: "i" 1)))))))))