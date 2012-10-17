DBQuery.prototype._prettyShell = true;
DBQuery.prototype.ugly = function () {
  this._prettyShell = false;
  return this;
};
