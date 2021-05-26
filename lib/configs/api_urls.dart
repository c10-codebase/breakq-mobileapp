/// ALL THE API ENDPOINT URLs for BreakQ Application
/// For more information visit: `http://breakq.api.magratechs.com/swagger/index.html`

/// BASE URL
const String apiBase = 'breakq.api.magratechs.com';
const String apiBaseFull = 'http://breakq.api.magratechs.com';

/// ENDPOINT URLs
const String apiCategory = '/api/Category';
const String apiBrand = '/api/Brand';
const String apiProducts = '/api/Products';

/// Query Parameters
const String apiCategoryQuery = 'categoryCode';
const String apiProductQuery = 'productName';
const String apiBrandCode = 'brandCode';
const String apiSortBy = 'sortBy';
const String apiFilterBy = 'filterBy';
const String apiFilterByValue = 'filterByValue';
const String apiPageNumber = 'pageNumber';

/// Filter Values
/// <param name="categoryCode"></param>
/// <param name="productName"></param>
/// <param name="brandCode"></param>
/// <param name="sortBy"> Possible values lowtohigh and hightolow</param>
/// <param name="filterBy">Possible values greaterthan,  lessthan ,minmax</param>
/// <param name="filterByValue"> For greaterthan and lessthan single number, for minmax two numbers separated by comma</param>
/// <param name="pageNumber">  1</param>

const String apiSortHTL = 'hightolow';
const String apiSortLTH = 'lowtohigh';
const String apiFilterByGT = 'greaterthan';
const String apiFilterByLT = 'lessthan';
const String apiFilterByMM = 'minmax';
