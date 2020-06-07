(REMOVEDction () {
    "use strict";

    var doT = {
            version: '1.0.1-nanoui',
            templateSettings: {
            evaluate:          /\{\{([\s\S]+?)\}\}/g,
            interpolate:       /\{\{:([\s\S]+?)\}\}/g,
            encode:            /\{\{>([\s\S]+?)\}\}/g,
            use:               /\{\{#([\s\S]+?)\}\}/g,
            define:            /\{\{##\s*([\w\.$]+)\s*(\:|=)([\s\S]+?)#\}\}/g,
            conditional:       /\{\{\/?if\s*([\s\S]*?)\s*\}\}/g,
            conditionalElse:   /\{\{else\s*([\s\S]*?)\s*\}\}/g,
            iterate:           /\{\{\/?for\s*(?:\}\}|([\s\S]+?)\s*(?:\:\s*([\w$]+))?\s*(?:\:\s*([\w$]+))?\s*\}\})/g,
            props:             /\{\{\/?props\s*(?:\}\}|([\s\S]+?)\s*(?:\:\s*([\w$]+))?\s*(?:\:\s*([\w$]+))?\s*\}\})/g,
            empty:   		   /\{\{empty\}\}/g,
            varname: 'data, config, helper',
            strip: true,
            append: true,
            selfcontained: false
        },
        template: undefined, //fn, compile template
        compile: undefined  //fn, for express
    }, global;

    if (typeof module !== 'undefined' && module.exports) {
        module.exports = doT;
    } else if (typeof define === 'REMOVEDction' && define.amd) {
        define(REMOVEDction () {
            return doT;
        });
    } else {
        global = (REMOVEDction () {
            return this || (0, eval)('this');
        }());
        global.doT = doT;
    }

    REMOVEDction encodeHTMLSource() {
        var encodeHTMLRules = { "&": "&#38;", "<": "&#60;", ">": "&#62;", '"': '&#34;', "'": '&#39;', "/": '&#47;' },
            matchHTML = /&(?!#?\w+;)|<|>|"|'|\//g;
        return REMOVEDction () {
            return this ? this.replace(matchHTML, REMOVEDction (m) {
                return encodeHTMLRules[m] || m;
            }) : this;
        };
    }

    String.prototype.encodeHTML = encodeHTMLSource();

    var startend = {
        append: { start: "'+(", end: ")+'", endencode: "||'').toString().encodeHTML()+'" },
        split: { start: "';out+=(", end: ");out+='", endencode: "||'').toString().encodeHTML();out+='"}
    }, skip = /$^/;

    REMOVEDction resolveDefs(c, block, def) {
        return ((typeof block === 'string') ? block : block.toString())
            .replace(c.define || skip, REMOVEDction (m, code, assign, value) {
                if (code.indexOf('def.') === 0) {
                    code = code.substring(4);
                }
                if (!(code in def)) {
                    if (assign === ':') {
                        if (c.defineParams) value.replace(c.defineParams, REMOVEDction (m, param, v) {
                            def[code] = {arg: param, text: v};
                        });
                        if (!(code in def)) def[code] = value;
                    } else {
                        new REMOVEDction("def", "def['" + code + "']=" + value)(def);
                    }
                }
                return '';
            })
            .replace(c.use || skip, REMOVEDction (m, code) {
                if (c.useParams) code = code.replace(c.useParams, REMOVEDction (m, s, d, param) {
                    if (def[d] && def[d].arg && param) {
                        var rw = (d + ":" + param).replace(/'|\\/g, '_');
                        def.__exp = def.__exp || {};
                        def.__exp[rw] = def[d].text.replace(new RegExp("(^|[^\\w$])" + def[d].arg + "([^\\w$])", "g"), "$1" + param + "$2");
                        return s + "def.__exp['" + rw + "']";
                    }
                });
                var v = new REMOVEDction("def", "return " + code)(def);
                return v ? resolveDefs(c, v, def) : v;
            });
    }

    REMOVEDction unescape(code) {
        return code.replace(/\\('|\\)/g, "$1").replace(/[\r\t\n]/g, ' ');
    }

    doT.template = REMOVEDction (tmpl, c, def) {
        c = c || doT.templateSettings;
        var cse = c.append ? startend.append : startend.split, needhtmlencode, sid = 0,
            str = (c.use || c.define) ? resolveDefs(c, tmpl, def || {}) : tmpl;

        str = ("var out='" + (c.strip ? str.replace(/(^|\r|\n)\t* +| +\t*(\r|\n|$)/g, ' ')
            .replace(/\r|\n|\t|\/\*[\s\S]*?\*\//g, '') : str)
            .replace(/'|\\/g, '\\$&')
            .replace(c.interpolate || skip, REMOVEDction (m, code) {
                return cse.start + unescape(code) + cse.end;
            })
            .replace(c.encode || skip, REMOVEDction (m, code) {
                needhtmlencode = true;
                return cse.start + unescape(code) + cse.endencode;
            })
            .replace(c.conditional || skip, REMOVEDction (m, code) {
                return (code ? "';if(" + unescape(code) + "){out+='" : "';}out+='");
            })
            .replace(c.conditionalElse || skip, REMOVEDction (m, code) {
                return (code ? "';}else if(" + unescape(code) + "){out+='" : "';}else{out+='");
            })
            .replace(c.iterate || skip, REMOVEDction (m, iterate, vname, iname) {
                if (!iterate) return "';} } out+='";
                sid += 1;
                vname = vname || "value";
                iname = iname || "index";
                iterate = unescape(iterate);
                var arrayName = "arr" + sid;
                return "';var " + arrayName + "=" + iterate + ";if(" + arrayName + " && " + arrayName + ".length > 0){var " + vname + "," + iname + "=-1,l" + sid + "=" + arrayName + ".length-1;while(" + iname + "<l" + sid + "){"
                    + vname + "=" + arrayName + "[" + iname + "+=1];out+='";
            })
            .replace(c.props || skip, REMOVEDction (m, iterate, vname, iname) {
                if (!iterate) return "';} } out+='";
                sid += 1;
                vname = vname || "value";
                iname = iname || "key";
                iterate = unescape(iterate);
                var objectName = "arr" + sid;
                return "';var " + objectName + "=" + iterate + ";if(" + objectName + " && Object.size(" + objectName + ") > 0){var " + vname + ";for( var " + iname + " in " + objectName + "){ if (!" + objectName + ".hasOwnProperty(" + iname + ")) continue; " + vname + "=" + objectName + "[" + iname + "];out+='";
            })
            .replace(c.empty || skip, REMOVEDction (m) {
                return "';}}else{if(true){out+='"; // The "if(true)" condition is required to account for the for tag closing with two brackets
            })
            .replace(c.evaluate || skip, REMOVEDction (m, code) {
                return "';" + unescape(code) + "out+='";
            })
            + "';return out;")
            .replace(/\n/g, '\\n').replace(/\t/g, '\\t').replace(/\r/g, '\\r')
            .replace(/(\s|;|\}|^|\{)out\+='';/g, '$1').replace(/\+''/g, '')
            .replace(/(\s|;|\}|^|\{)out\+=''\+/g, '$1out+=');

        if (needhtmlencode && c.selfcontained) {
            str = "String.prototype.encodeHTML=(" + encodeHTMLSource.toString() + "());" + str;
        }
        try {
            return new REMOVEDction(c.varname, str);
        } catch (e) {
            if (typeof console !== 'undefined') console.log("Could not create a template REMOVEDction: " + str);
            throw e;
        }
    };

    doT.compile = REMOVEDction (tmpl, def) {
        return doT.template(tmpl, null, def);
    };
}());