(Algorit (main)
 ((for main ((var "i") (var "x") (var "y") (list "a"))
   (
   (when start
    ((setVar:to: "x" "95")
     (setVar:to: "i" "1")
     (doUntil (more:than: (getVar "i") (lineCountOfList: "a"))
      ((setVar:to: "y" (getLine:ofList: (getVar "i") "a"))
       (doIf (equal:to: (getVar "x") (getVar "y"))
        ((print: (getVar "x"))
         (print: " is found at ")
         (println: (getVar "i"))
         (stopAll)))
       (changeVar:by: "i" 1)))
     (print: (getVar "x"))
     (println: " is not found")))
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 10 10 99 "a")))))))