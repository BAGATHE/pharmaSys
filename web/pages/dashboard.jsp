<%@ include file="elements/header.jsp" %>
<%@ include file="elements/sidebars.jsp" %>
<div class="main-panel">
    <div class="main-header">
      <div class="main-header-logo">
        <!-- Logo Header -->
        <div class="logo-header" data-background-color="dark">
          <a href="index.html" class="logo">
            <img
              src="<%= request.getContextPath() %>assets/img/kaiadmin/logo_light.svg"
              alt="navbar brand"
              class="navbar-brand"
              height="20"
            />
          </a>
          <div class="nav-toggle">
            <button class="btn btn-toggle toggle-sidebar">
              <i class="gg-menu-right"></i>
            </button>
            <button class="btn btn-toggle sidenav-toggler">
              <i class="gg-menu-left"></i>
            </button>
          </div>
          <button class="topbar-toggler more">
            <i class="gg-more-vertical-alt"></i>
          </button>
        </div>
        <!-- End Logo Header -->
      </div>
      <!-- Navbar Header -->
      <nav
        class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom"
      >
        <div class="container-fluid">
          <nav
            class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"
          >
            
          </nav>

          <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
           
           
          </ul>
        </div>
      </nav>
      <!-- End Navbar -->
    </div>

    <div class="container">
      <div class="page-inner">
        <div
          class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4"
        >
          <div>
            <h3 class="fw-bold mb-3">Dashboard</h3>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6 col-md-3">
            <div class="card card-stats card-round">
              <div class="card-body">
                <div class="row align-items-center">
                  <div class="col-icon">
                    <div
                      class="icon-big text-center icon-primary bubble-shadow-small"
                    >
                      <i class="fas fa-users"></i>
                    </div>
                  </div>
                  <div class="col col-stats ms-3 ms-sm-0">
                    <div class="numbers">
                      <p class="card-category">Visitors</p>
                      <h4 class="card-title">1,294</h4>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-md-3">
            <div class="card card-stats card-round">
              <div class="card-body">
                <div class="row align-items-center">
                  <div class="col-icon">
                    <div
                      class="icon-big text-center icon-info bubble-shadow-small"
                    >
                      <i class="fas fa-user-check"></i>
                    </div>
                  </div>
                  <div class="col col-stats ms-3 ms-sm-0">
                    <div class="numbers">
                      <p class="card-category">Subscribers</p>
                      <h4 class="card-title">1303</h4>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-md-3">
            <div class="card card-stats card-round">
              <div class="card-body">
                <div class="row align-items-center">
                  <div class="col-icon">
                    <div
                      class="icon-big text-center icon-success bubble-shadow-small"
                    >
                      <i class="fas fa-luggage-cart"></i>
                    </div>
                  </div>
                  <div class="col col-stats ms-3 ms-sm-0">
                    <div class="numbers">
                      <p class="card-category">Sales</p>
                      <h4 class="card-title">$ 1,345</h4>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-md-3">
            <div class="card card-stats card-round">
              <div class="card-body">
                <div class="row align-items-center">
                  <div class="col-icon">
                    <div
                      class="icon-big text-center icon-secondary bubble-shadow-small"
                    >
                      <i class="far fa-check-circle"></i>
                    </div>
                  </div>
                  <div class="col col-stats ms-3 ms-sm-0">
                    <div class="numbers">
                      <p class="card-category">Order</p>
                      <h4 class="card-title">576</h4>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="card card-round">
              <div class="card-header">
                <div class="card-head-row">
                  <div class="card-title">User Statistics</div>
                  <div class="card-tools">
                    <!--input date-->
                  </div>
                </div>
              </div>
              <div class="card-body">
                <div class="chart-container" style="min-height: 375px">
                  <canvas id="statisticsChart"></canvas>
                </div>
                <div id="myChartLegend"></div>
              </div>
            </div>
          </div>
        </div>


        


        <div class="row">
          <div class="col-md-12">
            <div class="card card-round">
              <div class="card-header">
                <div class="card-head-row card-tools-still-right">
                  <div class="card-title">Transaction History</div>
                  <div class="card-tools">
                    <div class="dropdown">
                      <button
                        class="btn btn-icon btn-clean me-0"
                        type="button"
                        id="dropdownMenuButton"
                        data-bs-toggle="dropdown"
                        aria-haspopup="true"
                        aria-expanded="false"
                      >
                        <i class="fas fa-ellipsis-h"></i>
                      </button>
                      <div
                        class="dropdown-menu"
                        aria-labelledby="dropdownMenuButton"
                      >
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#"
                          >Something else here</a
                        >
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-body p-0">
                <div class="table-responsive">
                  <!-- Projects table -->
                  <table class="table align-items-center mb-0">
                    <thead class="thead-light">
                      <tr>
                        <th scope="col">Payment Number</th>
                        <th scope="col" class="text-end">Date & Time</th>
                        <th scope="col" class="text-end">Amount</th>
                        <th scope="col" class="text-end">Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                      <tr>
                        <th scope="row">
                          <button
                            class="btn btn-icon btn-round btn-success btn-sm me-2"
                          >
                            <i class="fa fa-check"></i>
                          </button>
                          Payment from #10231
                        </th>
                        <td class="text-end">Mar 19, 2020, 2.45pm</td>
                        <td class="text-end">$250.00</td>
                        <td class="text-end">
                          <span class="badge badge-success">Completed</span>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
<%@ include file="elements/footer.jsp" %>