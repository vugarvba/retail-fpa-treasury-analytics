# Northstar Retail | FP&A and Treasury Analytics

**Python · SQL (SQLite) · Google Looker Studio · Financial planning · Cash forecasting**

A reproducible portfolio case study for a **fictional Dutch e-commerce retailer**. The project demonstrates how an analyst can move from transaction-level sales data to profitability analysis, budget-versus-actual reporting, working-capital estimates, and a direct 13-week liquidity forecast.

> **Data are synthetic.** Results are illustrative rather than forecasts or disclosures for an operating business.

## Project at a glance

| Analysis | Key finding |
| --- | --- |
| Jan–Oct 2026 actual revenue | €3,168,319 |
| Revenue variance vs budget | −€259,964.65 (−7.58%) |
| Jan–Oct 2026 actual EBITDA | €148,537.65 |
| EBITDA variance vs budget | −€112,467.86 (−43.09%) |
| Actual EBITDA margin | 4.69% |
| 13-week base-case closing cash | €478,629.65 |
| 13-week stressed closing cash | €397,886.24 |
| Minimum base-case liquidity headroom | €237,914.25 |

Monthly P&L is **January–October 2026**. Product profitability uses **January 2025–October 2026** data. The cash forecast covers **2 November 2026–31 January 2027** (13 Monday–Sunday weeks).

## Main questions

1. How far behind budget are revenue and EBITDA, and which months contributed most?
2. Which products drive sales versus gross profit and margin?
3. Does a sales shortfall arise from volume or average selling price changes?
4. How do inventory and supplier credit affect estimated cash conversion?
5. How resilient is liquidity when December customer receipts fall 20%?

## Selected findings

- **August 2026:** Revenue missed its budget by **€84,994.95** and gross profit by **€21,560.65**. Actual gross margin was **28.61%**, versus **27.84%** budgeted; the gross-profit miss was therefore driven primarily by revenue, not a deteriorating margin.
- **Laptops:** Represent **61.46%** of total sample revenue and **48.49%** of gross profit, with a **22.01%** gross margin. The **mouse** category has the highest gross margin (**51.40%**). These percentages cover the entire synthetic sales sample, not just 2026.
- **August laptop shortfall:** Under the assumption that budgeted 10% revenue growth came entirely from higher volume, volume explained **−€54,561.97**, partially offset by **+€1,497.97** in realized average selling price, reconciling to **−€53,064**.
- **2026 YTD EBITDA margin:** **4.69%** actual against **7.61%** budget. Operating profitability declined more sharply than revenue.
- **13-week liquidity:** Base-case closing cash **€478,629.65**, stress-case **€397,886.24**. Both remain above an illustrative **€150,000 minimum reserve**. The stress reduces December cash receipts by 20% and holds supplier and operating payments fixed.

## Outputs

| Path | Contents |
| --- | --- |
| `notebooks/northstar_retail_analysis.ipynb` | Cleaned, executed, sequential notebook with validation checks and charts |
| `sql/` | Five standalone SQLite queries covering monthly revenue, products and August diagnostics |
| `data/management_pnl.csv` | Monthly 2026 budget and actual P&L, 10 records |
| `data/product_profitability.csv` | Product-level sales and profitability, 6 records |
| `data/treasury_forecast.csv` | 13-week base and stress cash forecast |
| `figures/` | Generated risk/finance performance charts |
| `reports/northstar_dashboard.pdf` | Two-page export of the Looker Studio dashboard |

### Dashboard

**Page 1: FP&A** shows six revenue/EBITDA scorecards, monthly budget comparisons, an interactive month selector, and profitability by product. The product table's reporting period differs from the P&L and does not respond to the month selector.

**Page 2: Treasury** shows final base/stress cash, minimum headroom, weekly receipts/payments and the 13-week base/stress liquidity trajectories.

## Reproduce

In Google Colab, upload `notebooks/northstar_retail_analysis.ipynb` and select **Runtime → Run all**. Alternatively, install the dependencies below and run the notebook in Jupyter in the project root:

```bash
python -m pip install -r requirements.txt
jupyter notebook notebooks/northstar_retail_analysis.ipynb
```

The notebook builds its own synthetic source data using `numpy.random.default_rng(42)` and writes a local SQLite database. It then calculates the reports, saves the three CSV files, and saves plots in `figures/`. It does **not** require credentials, internet market data, a Power BI license, or access to the Looker Studio report.

The committed CSVs and dashboard PDF are frozen examples; rerunning the notebook creates the CSVs in the current working directory and may replace local outputs. Calculations were independently rerun against the notebook when this package was prepared.

## Core methodology and modelling choices

- **Synthetic sales:** 12,000 orders over January 2025–October 2026, six product types, fixed list prices and unit costs, random quantities and discounts. Random order dates are **not** calibrated to real-world retail seasonality.
- **2026 management budget:** Each 2026 month is budgeted at **110% of the corresponding 2025 month**, with the same proportional COGS. Planned monthly fixed operating costs: **€42,000 payroll/admin** plus **€14,000 marketing**; fulfillment **4% of budgeted revenue**. Actual costs: **€42,000 payroll/admin**, **€17,000 marketing**, fulfillment **4.5% of sales**.
- **EBITDA:** Gross profit minus simplified operating expenses. Not a complete statutory P&L; depreciation, interest and taxes are not modelled.
- **Working capital:** DIO **45 days**, DPO **30 days**, illustrative **30-day-month** convention; assume customers pay immediately. Operating cash flow ≈ EBITDA − change in estimated net working capital. The model starts from an assumed **€250,000 cash at 31 January 2026** because opening December 2025 balances were not constructed.
- **Monthly forward view:** 10% revenue growth over November/December 2025; 28% gross margin; same illustrative fixed expenses. Monthly closing cash is a separate indirect-method estimate.
- **Weekly direct cash flow:** Forecast spans 13 Monday–Sunday weeks beginning **2 November 2026**. Monthly revenue is allocated evenly across calendar days, customers pay immediately, assumed purchases equal **72% of revenue**, supplier payments lag **4 weeks**, and October purchases are proxied from October COGS for first four weeks. Payroll, marketing and fulfillment are prorated over days. Opening weekly cash is the rounded October closing cash derived from the indirect model (**€379,915.68**).
- **Stress case:** Reduce only **December 2026 cash receipts by 20%**, keep committed payments unchanged, and recalculate cumulative cash. **Minimum liquidity reserve: €150,000**.

### Limitations and improvements

This is an educational analysis, not a production-grade retail treasury model. In particular, the monthly DIO/DPO balance estimate and direct weekly forecast **do not reconcile through a single stock/purchases/AP ledger**. A stronger future version would explicitly forecast inventory receipts, inventory on hand, purchase orders, payable due dates, VAT, taxes, capex, financing, refunds, returns, and payroll dates; model variable demand and price seasonality; and compare forecast to actual bank transactions. Supplier payment timing is approximately 28 days, not an exact 30-day DPO. Week-start dates in the uploaded PDF may be formatted as daily dates by Looker Studio.

## Skills demonstrated

SQL querying and grouping · pandas financial analysis · budget variance decomposition · contribution margin and EBITDA analysis · scenario modelling · working capital estimation · direct-method cash forecasting · Looker Studio report design · model validation and limitations communication.

---

**Author note:** This is a personal educational finance portfolio case study using synthetic data and an independently rerunnable calculation pipeline.
