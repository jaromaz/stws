
    // SyncTerm BBS viewer as a Web Service
    // by Jaromaz https://jm.iq.pl

    window.addEventListener("load", function(event) {
        var modalContent = "";
        var modal = new tingle.modal({
            beforeClose: function() {
                modal.setContent("");
                return true;
            }
        });

        var modalTrig = document.querySelectorAll('[data-modal]');
        if(modalTrig.length > 0){
            for (let i = 0; i < modalTrig.length; i++) {
                var ex = modalTrig[i];
                _addMevent(ex);
            }
        }

        function _addMevent(ex){
            ex.addEventListener('click',function(event){
                event.preventDefault();
                var target = ex.getAttribute('data-modal');
                var ifrCnt = document.createElement('div');
                    ifrCnt.setAttribute("class", "iframe-content");
                    var ifr = document.createElement('iframe');
                    var src = ex.getAttribute('data-src');
                    if (src == 'files') {
                        src = location.protocol+'//'+location.hostname+(location.port ?
                        ':' + location.port : '') + '/files/';
                        ifr.setAttribute("onload",
                            "if (!!this.contentDocument && this.contentDocument.referrer.indexOf('vnc.h') !== -1)\
                            this.contentDocument.body.style.fontFamily='Arial, Helvetica'");
                    }

                    ifr.setAttribute("src", src);
                    ifr.setAttribute("frameBorder", 0);
                    ifr.setAttribute("width", "100%");
                    ifr.setAttribute("height", 
                                     ((window.innerHeight || 
                                     document.documentElement.clientHeight || 
                                     document.body.clientHeight) - 350));
                    ifrCnt.appendChild(ifr);
                    modal.setContent(ifrCnt);
                    modal.open();
            })
        }

    });
