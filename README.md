# ob-drawtiming

This org-mode babel extension enables you to manage drawtiming.

Refer to http://drawtiming.sourceforge.net/index.html

# Install

## Requirement

You need to install drawtiming.

## Manually

Add ob-drawtiming.el to your load-path with:

```
  (add-to-list 'load-path "/path/to/ob-drawtiming.el")
  (require 'ob-drawtiming)
```

## Configure

```
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((drawtiming . t)
     ))
```

# Example

From http://drawtiming.sourceforge.net/index.html

```
  #+begin_src drawtiming :file generated/out.png
   
  # initialize the signals
  POWER=0, FIRE=0, ARMED=0, LED=OFF, COUNT=N.
  # turn on the power
  POWER=1 => LED=GREEN.
  # fire once to arm
  FIRE=1.
  FIRE => ARMED=1.
  FIRE=0.
  # fire a second time
  FIRE=1.
  FIRE, ARMED => LED=RED;
  FIRE => COUNT="N+1".
   
  #+end_src
```

![out](https://user-images.githubusercontent.com/99948913/219631331-8d1cf06e-790a-41de-8742-3fe333f94121.png)

