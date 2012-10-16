// Generated by CoffeeScript 1.3.3
var Item;

Item = (function() {

  function Item(name, description, price) {
    this.name = name;
    this.description = description;
    this.price = price;
  }

  Item.prototype.use = function(target) {
    return "Nothing happens when you use " + this.name + " on " + target;
  };

  Item.prototype.toString = function() {
    return "Name: " + this.name + "\n				Description: " + this.description + "\n				Price: " + this.price;
  };

  return Item;

})();
