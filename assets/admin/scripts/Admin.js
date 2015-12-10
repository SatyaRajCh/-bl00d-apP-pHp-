/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var ajaxFlag = false;
var selectedRecords = [];
$(function () {
    Admin.init();
});
var Admin = function () {
    return {
        init: init,
        ajaxInit: ajaxInit
    };

    /**
     * ajaxInit
     * Page Functions laoding
     */
    function init() {
        initIndividualRowDelete();
        initFormValidations();
        initAjaxDataTable();
        initTableTrSelect();
        initMultipleRowsDelete();
        initDateRangePicker();
        initAjaxFormSubmit();
        initModalPopups();
        initSummernote();
    }

    /**
     * ajaxInit
     * This function will laod in ajax
     */
    function ajaxInit() {
        initFormValidations();
        initIndividualRowDelete();
        initAjaxFormSubmit();
        initSummernote();
        

    }

    /**
     * initConfirmMessageAlerts
     * @returns {undefined}
     */
    function initIndividualRowDelete() {
        $('.delete-confirm-alert').each(function () {
            $(this).click(function (e) {
                e.preventDefault();
                var deleteMessage = $(this).attr("data-message");
                var deleteUrl = $(this).attr('href');
                deleteMessage = (deleteMessage != '' && deleteMessage != 'undefined') ? deleteMessage : 'You are permenantly deleting this record!';
                swal({
                    title: "Are you sure?",
                    text: deleteMessage,
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Yes, I'm sure.",
                    closeOnConfirm: false
                }, function () {
                    if (ajaxFlag == false) {
                        ajaxFlag = true;
                        $.ajax({
                            url: deleteUrl,
                            type: 'GET',
                            contentType: false,
                            cache: false,
                            processData: false,
                            success: function (data, textStatus, jqXHR)
                            {
                                ajaxFlag = false;
                                var isJSON = true;
                                try {
                                    var jsonData = jQuery.parseJSON(data);
                                } catch (err) {
                                    isJSON = false;
                                }
                                if (isJSON) {
                                    if (typeof (jsonData.status) != 'undefined' && jsonData.status == 'success') {
                                        if (typeof (jsonData.message) != 'undefined') {
                                            swal({
                                                title: "Success!",
                                                text: jsonData.message,
                                                type: "success"
                                            },
                                            function () {
                                                location.reload(true);
                                            });
                                        }
                                    }
                                } else {
                                    swal({
                                        title: "Failed!",
                                        text: 'AJAX Request Failed',
                                        type: "success"
                                    });
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown)
                            {
                                ajaxFlag = false;
                                swal({
                                    title: "Failed!",
                                    text: 'AJAX Request Failed',
                                    type: "success"
                                });
                            }
                        });
                        e.preventDefault();
                    }

                });
            });
        });
    }

    function initFormValidations() {
        $('.validation-form').each(function () {
            $(this).validate();
        });
    }

    /**
     * initAjaxDataTable
     * @returns void
     */
    function initAjaxDataTable() {
        $(".ajax-dataTable").each(function () {
            var ajaxUrl = $(this).attr("data-href");
            var orderColumn = ($(this).attr("data-order") != null && $(this).attr("data-order") != "undefined") ? $(this).attr("data-order") : "";
            if (orderColumn == "users") {
                var order = [[9, "desc"]];
            } else {
                var order = [[0, "desc"]];
            }
            $(this).DataTable({
                "dom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "sSwfPath": SITEURL + "assets/admin/datatables/extensions/TableTools/swf/copy_csv_xls_pdf.swf",
                    "aButtons": ['copy', 'csv', {
                            "sExtends": "xls",
                            "sFileName": "*.xls",
                            "bFooter": false
                        }, 'pdf', 'print']
                },
                "processing": true,
                "serverSide": true,
                "ajax": ajaxUrl,
                "order": order
            });
        });

    }
    /**
     * initTableTrSelect
     * @returns {undefined}
     */
    function initTableTrSelect() {
        $(".ajax-dataTable").each(function () {
            $(this).on('click', 'tr', function () {
                var id = this.id;
                var index = $.inArray(id, selectedRecords);
                if (index === -1) {
                    selectedRecords.push(id);
                } else {
                    selectedRecords.splice(index, 1);
                }

                $(this).toggleClass('selected');
            });
        });
    }

    function initMultipleRowsDelete() {
        $(".multiple-rows-delete").each(function () {
            $(this).click(function (e) {
                e.preventDefault();
                var recordCnt = selectedRecords.length;
                if (recordCnt > 0) {
                    var deleteMessage = $(this).attr("data-message");
                    var deleteUrl = $(this).attr('href');
                    deleteMessage = (deleteMessage != '' && deleteMessage != 'undefined') ? deleteMessage : 'You are permenantly deleting this rows!';
                    swal({
                        title: "Are you sure?",
                        text: deleteMessage,
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "Yes, I'm sure.",
                        closeOnConfirm: false
                    }, function () {
                        if (ajaxFlag == false) {
                            ajaxFlag = true;
                            $.ajax({
                                url: deleteUrl,
                                type: 'POST',
                                data: {"selectedRecords": selectedRecords},
                                success: function (data, textStatus, jqXHR)
                                {
                                    ajaxFlag = false;
                                    selectedRecords = [];
                                    var isJSON = true;
                                    try {
                                        var jsonData = jQuery.parseJSON(data);
                                    } catch (err) {
                                        isJSON = false;
                                    }
                                    if (isJSON) {
                                        if (typeof (jsonData.status) != 'undefined' && jsonData.status == 'success') {
                                            if (typeof (jsonData.message) != 'undefined') {
                                                swal({
                                                    title: "Success!",
                                                    text: jsonData.message,
                                                    type: jsonData.status
                                                },
                                                function () {
                                                    location.reload(true);
                                                });
                                            }
                                        }
                                    } else {
                                        swal({
                                            title: "Failed!",
                                            text: 'AJAX Request Failed',
                                            type: "error"
                                        });
                                    }
                                },
                                error: function (jqXHR, textStatus, errorThrown)
                                {
                                    ajaxFlag = false;
                                    swal({
                                        title: "Failed!",
                                        text: 'AJAX Request Failed',
                                        type: "error"
                                    });
                                }
                            });
                            e.preventDefault();
                        }

                    });
                } else {
                    swal({
                        title: "Failed!",
                        text: 'Atlease select one record for delete.',
                        type: "error"
                    });
                }
            });
        })
    }

    /**
     * 
     * @returns {undefined}
     */
    function initDateRangePicker() {
        $('.input-daterange').datepicker({});
    }

    function initAjaxFormSubmit()
    {
        $('.ajax-form').each(function (ele) {
            var formObj = $(this);
            var buttonObj = formObj.find(':submit:last');
            var callback = typeof formObj.attr('callback') != 'undefined' ? formObj.attr('callback') : null;
            $(this).submit(function (e)
            {
                if (!formObj.valid()) {
                    return false;
                }
                //formObj.parent().html("Loading....");
                var OldButtonValue = (buttonObj.val() != '') ? buttonObj.val() : buttonObj.html();
                buttonObj.val('Loading...').html('Loading...');
                buttonObj.attr('disabled', true);
                var formURL = formObj.attr("action");

                if (window.FormData !== undefined)  // for HTML5 browsers
                {
                    var formData = new FormData(this);
                    $.ajax({
                        url: formURL,
                        type: 'POST',
                        data: formData,
                        mimeType: "multipart/form-data",
                        contentType: false,
                        cache: false,
                        processData: false,
                        success: function (data, textStatus, jqXHR)
                        {
                            var isJSON = true;
                            try {
                                var jsonData = jQuery.parseJSON(data);
                            } catch (err) {
                                isJSON = false;
                            }
                            if (isJSON) {
                                if (typeof (jsonData.status) != 'undefined' && jsonData.status == 'success') {
                                    if (callback != null) {
                                        window[callback]();
                                    } else {
                                        if (typeof (jsonData.message) != 'undefined') {
                                            swal({
                                                title: "Success!",
                                                text: jsonData.message,
                                                type: "success"
                                            },
                                            function () {
                                                location.reload(true);

                                            });
                                            buttonObj.val(OldButtonValue).html(OldButtonValue);
                                            buttonObj.attr('disabled', true);
                                        }
                                    }
                                }
                            } else {
                                /*swal({
                                 title: "Success!",
                                 text: 'Saving failed due to errors!',
                                 type: "success"
                                 });*/
                                formObj.parent().html(data);
                                ajaxInit();
                                buttonObj.val(OldButtonValue).html(OldButtonValue);
                                buttonObj.attr('disabled', false);


                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            swal({
                                title: "Failed!",
                                text: 'AJAX Request Failed',
                                type: "error"
                            });
                            buttonObj.val(OldButtonValue).html(OldButtonValue);
                            buttonObj.attr('disabled', false);
                        }
                    });
                    e.preventDefault();
                }
            });
        });
    }

    function initModalPopups() {
        $('.modal-popup').each(function (ele) {
            var $mymodal = $('#myModal');
            $mymodal.modal('hide');
            $(this).click(function (e) {
                e.preventDefault();
                //$mymodal.find('.modal-title').html($(this).attr('data-title'));
                $mymodal.find('.modal-content').load($(this).attr('href'), function () {
                    ajaxInit();
                });
                $('#myModal').modal('show');
            });
        });
    }
    /**
     * Summerynote
     */
    function initSummernote()
    {
        $('.summernote').summernote({height:150});
        var edit = function() {
            $('.click2edit').summernote({focus: true});
        };
        var save = function() {
            var aHTML = $('.click2edit').code(); //save HTML If you need(aHTML: array).
            $('.click2edit').destroy();
        };
    }
}();
function chartInit() {
    var lineData = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                label: "Example dataset",
                fillColor: "rgba(220,220,220,0.5)",
                strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [22, 44, 67, 43, 76, 45, 12]
            },
            {
                label: "Example dataset",
                fillColor: "rgba(98,203,49,0.5)",
                strokeColor: "rgba(98,203,49,0.7)",
                pointColor: "rgba(98,203,49,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(26,179,148,1)",
                data: [16, 32, 18, 26, 42, 33, 44]
            }
        ]
    };
    var lineOptions = {
        scaleShowGridLines: true,
        scaleGridLineColor: "rgba(0,0,0,.05)",
        scaleGridLineWidth: 1,
        bezierCurve: true,
        bezierCurveTension: 0.4,
        pointDot: true,
        pointDotRadius: 4,
        pointDotStrokeWidth: 1,
        pointHitDetectionRadius: 20,
        datasetStroke: true,
        datasetStrokeWidth: 1,
        datasetFill: true,
        responsive: true,
        maintainAspectRatio: true
    };


    var ctx = document.getElementById("deviceChart").getContext("2d");
    var myNewChart = new Chart(ctx).Line(lineData, lineOptions);


}