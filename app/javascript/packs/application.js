import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
import '../stylesheets/application';
import '../stylesheets/flash_message';
import '../stylesheets/style';
import '../stylesheets/top';
import '../stylesheets/cards';
import '../stylesheets/spot_show';

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

$(function(){
  setTimeout(function () {
    $("#flash_msg").hide();
  }, 3000);
});