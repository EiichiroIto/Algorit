(Algorit (main)
 ((for main ((var "h") (var "i") (var "swapped") (var "x") (var "y") (list "a"))
   (
   (when setup
    ((clearList: "a")
     (appendRandom:from:to:toList: 90 10 99 "a")))
   (when start
    ((setVar:to: "h" (lineCountOfList: "a"))
     (setVar:to: "swapped" "1")
     (doWhile (or:with: (more:than: (getVar "h") "1") (more:than: (getVar "swapped") "0"))
      ((setVar:to: "swapped" "0")
       (setVar:to: "h" (truncated: (divide:by: (getVar "h") 1.3)))
       (doIf (less:than: (getVar "h") "1")
        ((setVar:to: "h" "1")))
       (setVar:to: "i" "1")
       (doUntil (more:than: (plus:and: (getVar "i") (getVar "h")) (lineCountOfList: "a"))
        ((setVar:to: "x" (getLine:ofList: (getVar "i") "a"))
         (setVar:to: "y" (getLine:ofList: (plus:and: (getVar "i") (getVar "h")) "a"))
         (doIf (more:than: (getVar "x") (getVar "y"))
          ((swapLine:and:ofList: (getVar "i") (plus:and: (getVar "i") (getVar "h")) "a")
           (setVar:to: "swapped" "1")))
         (changeVar:by: "i" 1)))))))))))