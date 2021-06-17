<?php
// Avoid error of double implementation of class
if( !class_exists( 'Hook' ) ) {
    // Global var for Hook system
    global $hook;

    /**
     * Class to implement some hook with action and filter to support the overwriting of parameters and functionnality by plugins
     * Action make operations and return bool for operation result, Filters do actions on a default value and return if success, this value filtred
     *
     * @author Edouard Labre
     */
    class Hook {

        public $hooks = array();
        private $_default_priority = 10;

        /**
         * Constructor
         */
        function __construct() {} // EMPTY

        /**
         * Add action (function) to be executed for a specific hook
         *
         * @param string $hook_name : name of the hook to add action
         * @param mixed $function_name : name of the function (string), or object + name of the function (in an array)
         * @param int $priority : value of the priority to execute the action (lower for first execution)
         * @return bool
         * @author Edouard Labre
         */
        function add_action( $hook_name = '', $function_name = '', $priority = 0 ) {
            // Check vars values
            if( !isset( $function_name ) ) {
                return false;
            }
            // Sanitize priority with default value if needed
            if( !isset( $priority ) || ! ( intval( $priority ) > 0 ) ) {
                $priority = $this->_default_priority;
            }
            // Add function name to the hook
            $this->hooks[ $hook_name ][] = array(
                'name' => $function_name,
                'priority' => intval( $priority )
            );
            return true;
        }

        /**
         * Get all function for a specific hook or for all hooks
         *
         * @param string $hook_name
         * @return array : list of actions or list of hooks with list of actions
         * @author Edouard Labre
         */
        function get_hook( $hook_name = '' ) {
            // Return all hooks if no param or invalid param
            if( !isset( $hook_name ) || empty( $hook_name ) || !isset( $this->hooks[ $hook_name ] ) ) {
                return $this->hooks;
            }
            // Return list of functions for a specific hook
            return $this->hooks[ $hook_name ];
        }

        /**
         * Execute all action added for a hook
         *
         * @param string $hook_name : name of the hook to execute actions attached
         * @param array $akv_params : list of params : key (name of var) <=> value (value of var)
         * @param bool $try_function : define if the actions must be executed in a try catch
         * @return bool
         * @author Edouard Labre
         */
        function do_action( $hook_name = '', $akv_params = array(), $try_function = false ) {
            // Check if it's a valid hook to execute actions (if has no function, doesn't exist)
            if( empty( $hook_name ) || !isset( $this->hooks[ $hook_name ] ) ) {
                return false;
            }
            // Sanitize params if not an array
            if( !is_array( $akv_params ) ) {
                $akv_params = array();
            }
            // Sort functions by priority (low priority for first execution)
            ksort( $this->hooks[ $hook_name ] );
            // Loop on functions saved for this hook to execute them
            foreach( $this->hooks[ $hook_name ] as $function ) {
                // Use a try..catch system or not
                if( $try_function != true ) {
                    // check if function from a class
                    if( is_array( $function['name'] ) ) {
                        // Execute
                        $function['name'][0]->$function['name'][1]( $akv_params );
                    } else {
                        // Execute
                        $function['name']( $akv_params );
                    }
                } else {
                    try {
                        if( is_array( $function['name'] ) ) {
                            // Execute
                            $function['name'][0]->$function['name'][1]( $akv_params );
                        } else {
                            // Execute
                            $function['name']( $akv_params );
                        }
                    } catch ( Exception $exc ) {
                        echo $exc->getTraceAsString();
                    }
                }
            }
            return true;
        }

        /**
         * Return a value after some operations defined in hook to filtred it
         *
         * @param string $hook_name : name of the hook to apply action (filters)
         * @param mixed $value_to_filter : value to edit or replace by the filter
         * @param array $akv_params : list of parameters in an key/value array
         * @param bool $try_function : define if filter must be executed in a try catch
         * @return mixed string on success, bool (false) on failure
         * @author Edouard Labre
         */
        function apply_filter( $hook_name = '', $value_to_filter = false, $akv_params = array(), $try_function = false ) {
            // Check if valid hook to execute actions
            if( empty( $hook_name ) || !isset( $this->hooks[ $hook_name ] ) ) {
                // Return default value, unfiltred
                return $value_to_filter;
            }
            // Sanitize params if it's not an array
            if( !is_array( $akv_params ) ) {
                $akv_params = array();
            }
            // Sort functions by priority (low priority for first execution)
            ksort( $this->hooks[ $hook_name ] );

            // Loop on functions saved for this hook to execute them
            foreach( $this->hooks[ $hook_name ] as $function ) {
                // Use a try..catch or not
                if( $try_function != true ) {
                    // check if function from a class
                    if( is_array( $function['name'] ) ) {
                        // Execute
                        $value_to_filter = $function['name'][0]->$function['name'][1]( $value_to_filter, $akv_params );
                    } else {
                        // Execute
                        $value_to_filter = $function['name']( $value_to_filter, $akv_params );
                    }
                } else {
                    try {
                        if( is_array( $function['name'] ) ) {
                            // Execute
                            $value_to_filter = $function['name'][0]->$function['name'][1]( $value_to_filter, $akv_params );
                        } else {
                            // Execute
                            $value_to_filter = $function['name']( $value_to_filter, $akv_params );
                        }
                    } catch ( Exception $exc ) {
                        echo $exc->getTraceAsString();
                    }
                }
            }
            // Return filtred value
            return $value_to_filter;
        }
    }

    /*
     * FUNCTIONS
     *
     */
    // Function to execute easily do_action operation
    if( !function_exists( 'do_action' ) ) {
        /**
         * Just an alias to simplify call of actions for hooks, with optionnals parameters in an array (key value)
         *
         * @param string $hook_name
         * @param array $akv_params : all params that could be used by function in hooks (array key->value)
         * @param bool $try_function : catch any error in function call by the hook
         * @return bool
         * @author Edouard Labre
         */
        function do_action( $hook_name = '', $akv_params = array(), $try_function = false ) {
            global $hook;
            return $hook->do_action( $hook_name, $akv_params, $try_function );
        }
    } else {
        die( 'Function name : "do_action", is reserved for the Hook Class System.' );
    }

    if( !function_exists( 'apply_filter' ) ) {
        /**
         *
         * @global Hook $hook
         * @param string $hook_name
         * @param mixed $value_to_filter
         * @param array $akv_params
         * @param bool $try_function
         * @return mxied
         */
        function apply_filter( $hook_name = '', $value_to_filter = false, $akv_params = array(), $try_function = false ) {
            global $hook;
            return $hook->apply_filter( $hook_name, $value_to_filter, $akv_params, $try_function );
        }
    } else {
        die( 'Function name : "apply_filter", is reserved for the Hook Class System.' );
    }

    // Function to execute easily add_action
    if( !function_exists( 'add_action' ) ) {
        /**
         * Just an alias to simplify call of actions for hooks
         *
         * @global Hook $hook
         * @param string $hook_name
         * @param mixed $function_name
         * @param int $priority
         * @return bool
         * @author Edouard Labre
         */
        function add_action( $hook_name, $function_name, $priority = 0 ) {
            global $hook;
            return $hook->add_action( $hook_name, $function_name, $priority );
        }
    } else {
        die( 'Function name : "add_action", is reserved for the Hook Class System.' );
    }

    if( !function_exists( 'add_filter' ) ) {
        /**
         * Alias of add_action for filters
         *
         */
        function add_filter( $hook_name = '', $function_name = '', $priority = 0 ) {
            return add_action( $hook_name, $function_name, $priority );
        }
    } else {
        die( 'Function name : "add_filter", is reserved for the Hook Class System.' );
    }

    // Auto-launch the Hook Class, init it in global $hook var
    $hook = new Hook();
}