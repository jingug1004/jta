any.dialog = function()
{
    var f = {};
    var o = { options: {}, functions: {} };

    f.title = function()
    {
    };

    f.option = function()
    {
    };

    f.alert = function(message)
    {
        o.functionName = "ok";

        o.message = message;

        alert(o.message);

        return this;
    };

    f.confirm = function(message)
    {
        o.functionName = "cancel";

        o.message = message;

        if (confirm(o.message) == true) {
            o.functionName = "ok";
        }

        return this;
    };

    f.ask = function(message)
    {
        o.functionName = "no";

        o.message = message;

        if (confirm(o.message) == true) {
            o.functionName = "yes";
        }

        return this;
    };

    f.ok = function(func)
    {
        if (o.functionName == "ok") {
            func();
        }

        return this;
    };

    f.cancel = function(func)
    {
        if (o.functionName == "cancel") {
            func();
        }

        return this;
    };

    f.yes = function(func)
    {
        if (o.functionName == "yes") {
            func();
        }

        return this;
    };

    f.no = function(func)
    {
        if (o.functionName == "no") {
            func();
        }

        return this;
    };

    return f;
};
