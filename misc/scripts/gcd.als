(Algorit (main)
 ((for main ((var "x") (var "y") )
   (
   (when start
    ((setVar:to: "x" "240")
     (setVar:to: "y" "208")
     (doUntil (equal:to: (getVar "x") (getVar "y"))
      ((doIfElse (more:than: (getVar "x") (getVar "y"))
        ((setVar:to: "x" (minus:with: (getVar "x") (getVar "y"))))
        ((setVar:to: "y" (minus:with: (getVar "y") (getVar "x")))))))
     (print: "gcd is ")
     (println: (getVar "x"))))))))