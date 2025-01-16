<%@ include file="elements/header.jsp" %>
<%@ include file="elements/sidebars.jsp" %>
<div class="main-panel">
    <div >
      <div class="page-inner">
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
          <div class="col-7">
            <div class="card " style="max-height: 64vh; overflow: hidden;">
              <div class="card-header">
                <form method="POST" action="" class="row g-3">
                  <div class="col-3">
                    <select name="" id="" class="form-select">
                        <option value="">-- Toutes les XXX --</option>
                    </select>
                  </div>
                  <div class="col-3">
                    <select name="" id="" class="form-select">
                        <option value="">-- Toutes les XXX --</option>
                    </select>
                  </div>
                  <div class="col-2">
                    <button type="submit" class="btn btn-success">Valider</button>
                </div>
                </form>
              </div>
              <div class="card-body" style="overflow-y: auto;">
                <ul class="nav nav-pills nav-secondary" id="pills-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="pills-chart-1-tab" data-bs-toggle="pill" href="#pills-chart-1" role="tab" aria-controls="pills-chart-1" aria-selected="true">chart</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="pills-tableau-1-tab" data-bs-toggle="pill" href="#pills-tableau-1" role="tab" aria-controls="pills-tableau-1" aria-selected="false">tableau</a>
                  </li>
                </ul>
                <div class="tab-content mt-2 mb-3" id="pills-tabContent">
                  <div class="tab-pane fade show active " id="pills-chart-1" role="tabpanel" aria-labelledby="pills-chart-1-tab">
                    <div class="chart-container">
                      <canvas id="lineChart"></canvas>
                    </div>
                  </div>
                  <div class="tab-pane fade" id="pills-tableau-1" role="tabpanel" aria-labelledby="pills-tableau-1-tab">
                    <div class="table-responsive">
                      <table class="table align-items-center mb-0">
                        <thead class="thead-light">
                          <tr>
                            <th scope="col">Payment Number</th>
                            <th scope="col" class="text-end">Date & Time</th>
                            <th scope="col" class="text-end">Amount</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
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
          <div class="col-5">
            <div class="card" style="max-height: 64vh; overflow: hidden;">
              <div class="card-header">
                <form method="POST" action="" class="row g-3">
                  <div class="col-3">
                    <select name="" id="" class="form-select">
                        <option value="">-- Toutes les XXX --</option>
                    </select>
                  </div>
                  <div class="col-3">
                    <select name="" id="" class="form-select">
                        <option value="">-- Toutes les XXX --</option>
                    </select>
                  </div>
                  <div class="col-2">
                    <button type="submit" class="btn btn-success">Valider</button>
                </div>
                </form>
              </div>
              <div class="card-body" style="overflow-y: auto;" >
                <ul class="nav nav-pills nav-secondary" id="pills-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="pills-chart-2-tab" data-bs-toggle="pill" href="#pills-chart-2" role="tab" aria-controls="pills-chart-2" aria-selected="true">chart</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="pills-tableau-2-tab" data-bs-toggle="pill" href="#pills-tableau-2" role="tab" aria-controls="pills-tableau-2" aria-selected="false">tableau</a>
                  </li>
                </ul>
                <div class="tab-content mt-2 mb-3" id="pills-tabContent">
                  <div class="tab-pane fade show active " id="pills-chart-2" role="tabpanel" aria-labelledby="pills-chart-2-tab">
                    <div class="chart-container">
                      <canvas
                        id="pieChart"
                        style="width: 50%; height: 50%"
                      ></canvas>
                    </div>
                  </div>
                  <div class="tab-pane fade" id="pills-tableau-2" role="tabpanel" aria-labelledby="pills-tableau-2-tab">
                    <div class="table-responsive">
                      <table class="table align-items-center mb-0">
                        <thead class="thead-light">
                          <tr>
                            <th scope="col">Payment Number</th>
                            <th scope="col" class="text-end">Date & Time</th>
                            <th scope="col" class="text-end">Amount</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
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

        <div class="row">
          <div class="col-10 offset-1">
            <div class="card" style="max-height: 64vh; overflow: hidden;">
              <div class="card-header">
                <ul class="nav nav-pills nav-secondary" id="pills-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="pills-chartA-3-tab" data-bs-toggle="pill" href="#pills-chartA-3" role="tab" aria-controls="pills-chartA-3" aria-selected="true">Annuelle</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link " id="pills-chartM-3-tab" data-bs-toggle="pill" href="#pills-chartM-3" role="tab" aria-controls="pills-chartM-3" aria-selected="true">Mensuelle</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="pills-tableau-3-tab" data-bs-toggle="pill" href="#pills-tableau-3" role="tab" aria-controls="pills-tableau-3" aria-selected="false">tableau</a>
                  </li>
                </ul>

              </div>
              <div class="card-body" style="overflow-y: auto;">
                
                <div class="tab-content mt-2 mb-3" id="pills-tabContent">
                  <div class="tab-pane fade show active " id="pills-chartA-3" role="tabpanel" aria-labelledby="pills-chartA-3-tab">
                    <form method="POST" action="" class="row g-3">
                      <div class="col-3">
                        <select name="" id="" class="form-select">
                            <option value="">-- Toutes les XXX --</option>
                        </select>
                      </div>
                      <div class="col-3">
                        <select name="" id="" class="form-select">
                            <option value="">-- Toutes les XXX --</option>
                        </select>
                      </div>
                      <div class="col-2">
                        <button type="submit" class="btn btn-success">Valider</button>
                    </div>
                    </form>
                    <div class="chart-container">
                      <canvas id="barChart"></canvas>
                    </div>
                  </div>
                  <div class="tab-pane fade show active " id="pills-chartM-3" role="tabpanel" aria-labelledby="pills-chartM-3-tab">
                    <form method="POST" action="" class="row g-3">
                      <div class="col-3">
                        <select name="" id="" class="form-select">
                            <option value="">-- Toutes les XXX --</option>
                        </select>
                      </div>
                      <div class="col-3">
                        <select name="" id="" class="form-select">
                            <option value="">-- Toutes les XXX --</option>
                        </select>
                      </div>
                      <div class="col-2">
                        <button type="submit" class="btn btn-success">Valider</button>
                    </div>
                    </form>
                    <div class="chart-container">
                      <canvas id="barChartMonthly"></canvas>
                    </div>
                  </div>
                  <div class="tab-pane fade" id="pills-tableau-3" role="tabpanel" aria-labelledby="pills-tableau-3-tab">
                    <div class="table-responsive">
                      <table class="table align-items-center mb-0">
                        <thead class="thead-light">
                          <tr>
                            <th scope="col">Payment Number</th>
                            <th scope="col" class="text-end">Date & Time</th>
                            <th scope="col" class="text-end">Amount</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
                            <td class="text-end">Mar 19, 2020, 2.45pm</td>
                            <td class="text-end">$250.00</td>
                            <td class="text-end">
                              <span class="badge badge-success">Completed</span>
                            </td>
                          </tr> 
                          <tr>
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
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Chart JS -->
<script src="<%= request.getContextPath() %>/assets/js/plugin/chart.js/chart.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/chart/dashboard/linechart.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/chart/dashboard/barchart.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/chart/dashboard/piechart.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/chart/dashboard/barchartmonth.js"></script>
<%@ include file="elements/footer.jsp" %>
