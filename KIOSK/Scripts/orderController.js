(function () {
    'use strict';

    angular
        .module('app')
        .controller('orderController', orderController);

    orderController.$inject = ['$location'];

    function orderController($location) {
        /* jshint validthis:true */
        var vm = this;
        vm.title = 'orderController';

        activate();

        function activate() { }
    }
})();
