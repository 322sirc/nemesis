{
  pkgs,
  ...
}: let
  w = pkgs.wlogout;
in {
  xdg.configFile."wlogout/style.css".text = ''
    * {
  background-image: none;
}

window {
  background-color: rgba(17, 17, 27, 0.6);
}

button {
    color: #b4befe;
  background-color: rgba(17, 17, 27, 0.0);
  outline-style: none;
  border: none;
  border-width: 0px;
  background-repeat: no-repeat;
  background-position: center;
  background-size: 10%;
  border-radius: 20px;
  box-shadow: none;
  text-shadow: none;
      animation: gradient_f 20s ease-in infinite;
}

button:hover#lock {
  /*background-color: #cba6f7;*/
  background-size: 25%;
  margin-right : 30px;
  margin-bottom : 30px;
  border-radius: 20px;
      animation: gradient_f 20s ease-in infinite;
      transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

button:hover#logout {
  /*background-color: #cba6f7;*/
  background-size: 25%;
  margin-right : 30px;
  margin-top : 30px;
  border-radius: 20px;
      animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

button:hover#shutdown {
  /*background-color: #cba6f7;*/
  background-size: 25%;
  margin-left : 20px;
  margin-bottom : 30px;
  border-radius: 20px;
      animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

button:hover#reboot {
  /*background-color: #cba6f7;*/
  background-size: 25%;
  margin-left : 30px;
  margin-top : 30px;
  border-radius: 20px;
      animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

button:hover#suspend {
  /*background-color: #cba6f7;*/
  background-size: 25%;
  margin-left : 30px;
  margin-top : 30px;
  border-radius: 20px;
      animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

button:hover#hibernate {
  /*background-color: #cba6f7;*/
  background-size: 25%;
  margin-left : 30px;
  margin-top : 30px;
  border-radius: 20px;
      animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
}

#lock {
        background-image: image(url("${w}/share/wlogout/icons/lock.png"), url("${w}/local/share/wlogout/icons/lock.png"));
    }
    #logout {
        background-image: image(url("${w}/share/wlogout/icons/logout.png"), url("${w}/local/share/wlogout/icons/logout.png"));
    }
    #suspend {
        background-image: image(url("${w}/share/wlogout/icons/suspend.png"), url("${w}/local/share/wlogout/icons/suspend.png"));
    }
    #hibernate {
        background-image: image(url("${w}/share/wlogout/icons/hibernate.png"), url("${w}/local/share/wlogout/icons/hibernate.png"));
    }
    #shutdown {
        background-image: image(url("${w}/share/wlogout/icons/shutdown.png"), url("${w}/local/share/wlogout/icons/shutdown.png"));
    }
    #reboot {
        background-image: image(url("${w}/share/wlogout/icons/reboot.png"), url("${w}/local/share/wlogout/icons/reboot.png"));
    
    }

  '';
}