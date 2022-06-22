(Algorit (main)
 ((for main ((var "i") (var "j") (var "x") (var "y") (list "a"))
   (
   (when start
    ((setVar:to: "i" (lineCountOfList: "a"))
     (doUntil (equal:to: (getVar "i") "1")
      ((setVar:to: "j" "1")
       (doUntil (equal:to: (getVar "i") (getVar "j"))
        ((setVar:to: "x" (getLine:ofList: (getVar "j") "a"))
         (setVar:to: "y" (getLine:ofList: (plus:and: (getVar "j") 1) "a"))
         (doIf (more:than: (getVar "x") (getVar "y"))
          ((swapLine:and:ofList: (getVar "j") (plus:and: (getVar "j") 1) "a")))
         (changeVar:by: "j" 1)))
       (changeVar:by: "i" -1)))))
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 20 10 99 "a")))))))