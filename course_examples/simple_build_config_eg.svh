
//This is a  pseudo code example for how  build flow works form a test class down to env and to agents and sub components
//while configuring same as well
///////////////////////////////////////////

class spi_test_base extends uvm_test;
  // UVM Factory Registration Macro
  `uvm_component_utils(spi_test_base)
  //------------------------------------------
  // Data Members
  //------------------------------------------
  //------------------------------------------
  // Component Members
  //------------------------------------------
  
  // The environment class
  spi_env m_env;
  // Configuration objects
  spi_env_config m_env_cfg;
  apb_agent_config m_apb_cfg;
  spi_agent_config m_spi_cfg;

  // Build the env, create the env configuration
  // including any sub configurations and assigning virtual interfaces
  function void build_phase( uvm_phase phase );
    // Create env configuration object
    m_env_cfg = spi_env_config::type_id::create("m_env_cfg");
    // Call function to configure the env
    configure_env(m_env_cfg);
    // Create apb agent configuration object
    m_apb_cfg = apb_agent_config::type_id::create("m_apb_cfg");
    // Call function to configure the apb_agent
    configure_apb_agent(m_apb_cfg);
  endfunction: build_phase

  //configure env config - can extend in derived tests
  function void configure_env(spi_env_config cfg);
    cfg.has_functional_coverage = 1;
    cfg.has_reg_scoreboard = 0;
    cfg.has_spi_scoreboard = 1;
  endfunction: configure_env


  // Convenience function to configure the apb agent
  // This can also be extended by derived classes
  function void configure_apb_agent(apb_agent_config cfg);
    cfg.active = UVM_ACTIVE;
    cfg.has_functional_coverage = 0;
    cfg.has_scoreboard = 0;
  endfunction: configure_apb_agent
  
endclass: spi_test_base

