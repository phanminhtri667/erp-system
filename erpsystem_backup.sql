--
-- PostgreSQL database dump
--

\restrict LIbEaQaYR8y9SIOzmRNLKTzK8wURbsYryCmsbXfSOoCoFrYXVgtHUskLnsFSglW

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ban_hang; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ban_hang;


ALTER SCHEMA ban_hang OWNER TO postgres;

--
-- Name: crm_khach_hang; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA crm_khach_hang;


ALTER SCHEMA crm_khach_hang OWNER TO postgres;

--
-- Name: ke_toan_tien; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ke_toan_tien;


ALTER SCHEMA ke_toan_tien OWNER TO postgres;

--
-- Name: kho_ton; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA kho_ton;


ALTER SCHEMA kho_ton OWNER TO postgres;

--
-- Name: mau_custom; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mau_custom;


ALTER SCHEMA mau_custom OWNER TO postgres;

--
-- Name: mua_hang_nhap_kho_qc_tag; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mua_hang_nhap_kho_qc_tag;


ALTER SCHEMA mua_hang_nhap_kho_qc_tag OWNER TO postgres;

--
-- Name: nha_cung_cap_soi; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA nha_cung_cap_soi;


ALTER SCHEMA nha_cung_cap_soi OWNER TO postgres;

--
-- Name: nhan_su; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA nhan_su;


ALTER SCHEMA nhan_su OWNER TO postgres;

--
-- Name: san_pham; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA san_pham;


ALTER SCHEMA san_pham OWNER TO postgres;

--
-- Name: system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA system;


ALTER SCHEMA system OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: deliveries; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.deliveries (
    id integer NOT NULL,
    so_id integer,
    wh_id integer,
    delivery_no character varying(50) NOT NULL,
    delivery_date date,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT deliveries_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('SHIPPED'::character varying)::text, ('DELIVERED'::character varying)::text])))
);


ALTER TABLE ban_hang.deliveries OWNER TO postgres;

--
-- Name: deliveries_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.deliveries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.deliveries_id_seq OWNER TO postgres;

--
-- Name: deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.deliveries_id_seq OWNED BY ban_hang.deliveries.id;


--
-- Name: delivery_items; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.delivery_items (
    id integer NOT NULL,
    delivery_id integer,
    so_item_id integer,
    qty_delivered_actual integer
);


ALTER TABLE ban_hang.delivery_items OWNER TO postgres;

--
-- Name: delivery_items_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.delivery_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.delivery_items_id_seq OWNER TO postgres;

--
-- Name: delivery_items_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.delivery_items_id_seq OWNED BY ban_hang.delivery_items.id;


--
-- Name: estimate_items; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.estimate_items (
    id integer NOT NULL,
    estimate_id integer,
    product_variant_id integer,
    qty integer,
    unit_price numeric(10,2),
    discount numeric(10,2),
    amount numeric(10,2)
);


ALTER TABLE ban_hang.estimate_items OWNER TO postgres;

--
-- Name: estimate_items_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.estimate_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.estimate_items_id_seq OWNER TO postgres;

--
-- Name: estimate_items_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.estimate_items_id_seq OWNED BY ban_hang.estimate_items.id;


--
-- Name: estimates; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.estimates (
    id integer NOT NULL,
    customer_id integer,
    est_no character varying(50) NOT NULL,
    version integer DEFAULT 1,
    est_date date DEFAULT CURRENT_DATE,
    valid_until date,
    currency character varying(10),
    total numeric(10,2),
    notes text,
    visible_to_customer boolean DEFAULT true
);


ALTER TABLE ban_hang.estimates OWNER TO postgres;

--
-- Name: estimates_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.estimates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.estimates_id_seq OWNER TO postgres;

--
-- Name: estimates_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.estimates_id_seq OWNED BY ban_hang.estimates.id;


--
-- Name: sales_order_items; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.sales_order_items (
    id integer NOT NULL,
    so_id integer,
    product_variant_id integer,
    qty_ordered integer,
    unit_price numeric(10,2),
    discount numeric(10,2),
    amount numeric(10,2),
    currency character varying(10),
    image_file_id integer
);


ALTER TABLE ban_hang.sales_order_items OWNER TO postgres;

--
-- Name: sales_order_items_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.sales_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.sales_order_items_id_seq OWNER TO postgres;

--
-- Name: sales_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.sales_order_items_id_seq OWNED BY ban_hang.sales_order_items.id;


--
-- Name: sales_orders; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.sales_orders (
    id integer NOT NULL,
    customer_id integer,
    so_no character varying(50) NOT NULL,
    from_estimate_id integer,
    order_date date DEFAULT CURRENT_DATE,
    promised_dates jsonb,
    status character varying(20) DEFAULT 'NEW'::character varying,
    deposit_amount numeric(10,2),
    deposit_percent numeric(5,2),
    currency character varying(10),
    totals jsonb,
    CONSTRAINT sales_orders_status_check CHECK (((status)::text = ANY (ARRAY[('NEW'::character varying)::text, ('PARTIAL'::character varying)::text, ('FULL'::character varying)::text])))
);


ALTER TABLE ban_hang.sales_orders OWNER TO postgres;

--
-- Name: sales_orders_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.sales_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.sales_orders_id_seq OWNER TO postgres;

--
-- Name: sales_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.sales_orders_id_seq OWNED BY ban_hang.sales_orders.id;


--
-- Name: so_settlements; Type: TABLE; Schema: ban_hang; Owner: postgres
--

CREATE TABLE ban_hang.so_settlements (
    id integer NOT NULL,
    so_id integer,
    amount numeric(10,2),
    reason text,
    settled_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE ban_hang.so_settlements OWNER TO postgres;

--
-- Name: so_settlements_id_seq; Type: SEQUENCE; Schema: ban_hang; Owner: postgres
--

CREATE SEQUENCE ban_hang.so_settlements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ban_hang.so_settlements_id_seq OWNER TO postgres;

--
-- Name: so_settlements_id_seq; Type: SEQUENCE OWNED BY; Schema: ban_hang; Owner: postgres
--

ALTER SEQUENCE ban_hang.so_settlements_id_seq OWNED BY ban_hang.so_settlements.id;


--
-- Name: crm_leads; Type: TABLE; Schema: crm_khach_hang; Owner: postgres
--

CREATE TABLE crm_khach_hang.crm_leads (
    id integer NOT NULL,
    customer_id integer,
    source character varying(255),
    stage character varying(255),
    reason_win text,
    reason_lose text,
    journey_notes text
);


ALTER TABLE crm_khach_hang.crm_leads OWNER TO postgres;

--
-- Name: crm_leads_id_seq; Type: SEQUENCE; Schema: crm_khach_hang; Owner: postgres
--

CREATE SEQUENCE crm_khach_hang.crm_leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE crm_khach_hang.crm_leads_id_seq OWNER TO postgres;

--
-- Name: crm_leads_id_seq; Type: SEQUENCE OWNED BY; Schema: crm_khach_hang; Owner: postgres
--

ALTER SEQUENCE crm_khach_hang.crm_leads_id_seq OWNED BY crm_khach_hang.crm_leads.id;


--
-- Name: customer_banks; Type: TABLE; Schema: crm_khach_hang; Owner: postgres
--

CREATE TABLE crm_khach_hang.customer_banks (
    id integer NOT NULL,
    customer_id integer,
    bank_name character varying(255),
    account_no character varying(50),
    owner character varying(255),
    qr_file_id integer
);


ALTER TABLE crm_khach_hang.customer_banks OWNER TO postgres;

--
-- Name: customer_banks_id_seq; Type: SEQUENCE; Schema: crm_khach_hang; Owner: postgres
--

CREATE SEQUENCE crm_khach_hang.customer_banks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE crm_khach_hang.customer_banks_id_seq OWNER TO postgres;

--
-- Name: customer_banks_id_seq; Type: SEQUENCE OWNED BY; Schema: crm_khach_hang; Owner: postgres
--

ALTER SEQUENCE crm_khach_hang.customer_banks_id_seq OWNED BY crm_khach_hang.customer_banks.id;


--
-- Name: customer_interest; Type: TABLE; Schema: crm_khach_hang; Owner: postgres
--

CREATE TABLE crm_khach_hang.customer_interest (
    id integer NOT NULL,
    customer_id integer,
    product_category character varying(255),
    tags text,
    notes text
);


ALTER TABLE crm_khach_hang.customer_interest OWNER TO postgres;

--
-- Name: customer_interest_id_seq; Type: SEQUENCE; Schema: crm_khach_hang; Owner: postgres
--

CREATE SEQUENCE crm_khach_hang.customer_interest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE crm_khach_hang.customer_interest_id_seq OWNER TO postgres;

--
-- Name: customer_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: crm_khach_hang; Owner: postgres
--

ALTER SEQUENCE crm_khach_hang.customer_interest_id_seq OWNED BY crm_khach_hang.customer_interest.id;


--
-- Name: customer_price_history; Type: TABLE; Schema: crm_khach_hang; Owner: postgres
--

CREATE TABLE crm_khach_hang.customer_price_history (
    id integer NOT NULL,
    customer_id integer,
    product_id integer,
    price numeric(10,2),
    currency character varying(10),
    valid_from date,
    valid_to date
);


ALTER TABLE crm_khach_hang.customer_price_history OWNER TO postgres;

--
-- Name: customer_price_history_id_seq; Type: SEQUENCE; Schema: crm_khach_hang; Owner: postgres
--

CREATE SEQUENCE crm_khach_hang.customer_price_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE crm_khach_hang.customer_price_history_id_seq OWNER TO postgres;

--
-- Name: customer_price_history_id_seq; Type: SEQUENCE OWNED BY; Schema: crm_khach_hang; Owner: postgres
--

ALTER SEQUENCE crm_khach_hang.customer_price_history_id_seq OWNED BY crm_khach_hang.customer_price_history.id;


--
-- Name: customers; Type: TABLE; Schema: crm_khach_hang; Owner: postgres
--

CREATE TABLE crm_khach_hang.customers (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(20),
    addresses jsonb,
    tax_code character varying(50),
    notes text
);


ALTER TABLE crm_khach_hang.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: crm_khach_hang; Owner: postgres
--

CREATE SEQUENCE crm_khach_hang.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE crm_khach_hang.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: crm_khach_hang; Owner: postgres
--

ALTER SEQUENCE crm_khach_hang.customers_id_seq OWNED BY crm_khach_hang.customers.id;


--
-- Name: ap_bills; Type: TABLE; Schema: ke_toan_tien; Owner: postgres
--

CREATE TABLE ke_toan_tien.ap_bills (
    id integer NOT NULL,
    po_id integer,
    bill_no character varying(50) NOT NULL,
    date date DEFAULT CURRENT_DATE,
    due_date date,
    amount numeric(15,2),
    currency character varying(10),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT ap_bills_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('PAID'::character varying)::text, ('OVERDUE'::character varying)::text])))
);


ALTER TABLE ke_toan_tien.ap_bills OWNER TO postgres;

--
-- Name: ap_bills_id_seq; Type: SEQUENCE; Schema: ke_toan_tien; Owner: postgres
--

CREATE SEQUENCE ke_toan_tien.ap_bills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ke_toan_tien.ap_bills_id_seq OWNER TO postgres;

--
-- Name: ap_bills_id_seq; Type: SEQUENCE OWNED BY; Schema: ke_toan_tien; Owner: postgres
--

ALTER SEQUENCE ke_toan_tien.ap_bills_id_seq OWNED BY ke_toan_tien.ap_bills.id;


--
-- Name: ar_invoices; Type: TABLE; Schema: ke_toan_tien; Owner: postgres
--

CREATE TABLE ke_toan_tien.ar_invoices (
    id integer NOT NULL,
    so_id integer,
    invoice_no character varying(50) NOT NULL,
    date date DEFAULT CURRENT_DATE,
    due_date date,
    amount numeric(15,2),
    currency character varying(10),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT ar_invoices_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('PAID'::character varying)::text, ('OVERDUE'::character varying)::text])))
);


ALTER TABLE ke_toan_tien.ar_invoices OWNER TO postgres;

--
-- Name: ar_invoices_id_seq; Type: SEQUENCE; Schema: ke_toan_tien; Owner: postgres
--

CREATE SEQUENCE ke_toan_tien.ar_invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ke_toan_tien.ar_invoices_id_seq OWNER TO postgres;

--
-- Name: ar_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: ke_toan_tien; Owner: postgres
--

ALTER SEQUENCE ke_toan_tien.ar_invoices_id_seq OWNED BY ke_toan_tien.ar_invoices.id;


--
-- Name: balances_daily; Type: TABLE; Schema: ke_toan_tien; Owner: postgres
--

CREATE TABLE ke_toan_tien.balances_daily (
    id integer NOT NULL,
    as_of_date date DEFAULT CURRENT_DATE,
    bank_account_id integer,
    balance_ar_total numeric(15,2),
    ap_total numeric(15,2)
);


ALTER TABLE ke_toan_tien.balances_daily OWNER TO postgres;

--
-- Name: balances_daily_id_seq; Type: SEQUENCE; Schema: ke_toan_tien; Owner: postgres
--

CREATE SEQUENCE ke_toan_tien.balances_daily_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ke_toan_tien.balances_daily_id_seq OWNER TO postgres;

--
-- Name: balances_daily_id_seq; Type: SEQUENCE OWNED BY; Schema: ke_toan_tien; Owner: postgres
--

ALTER SEQUENCE ke_toan_tien.balances_daily_id_seq OWNED BY ke_toan_tien.balances_daily.id;


--
-- Name: bank_accounts; Type: TABLE; Schema: ke_toan_tien; Owner: postgres
--

CREATE TABLE ke_toan_tien.bank_accounts (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    bank_name character varying(255) NOT NULL,
    account_no character varying(50) NOT NULL,
    owner character varying(255),
    qr_file_id integer,
    currency character varying(10),
    opening_balance numeric(15,2) DEFAULT 0
);


ALTER TABLE ke_toan_tien.bank_accounts OWNER TO postgres;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE; Schema: ke_toan_tien; Owner: postgres
--

CREATE SEQUENCE ke_toan_tien.bank_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ke_toan_tien.bank_accounts_id_seq OWNER TO postgres;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: ke_toan_tien; Owner: postgres
--

ALTER SEQUENCE ke_toan_tien.bank_accounts_id_seq OWNED BY ke_toan_tien.bank_accounts.id;


--
-- Name: cashbooks; Type: TABLE; Schema: ke_toan_tien; Owner: postgres
--

CREATE TABLE ke_toan_tien.cashbooks (
    id integer NOT NULL,
    tx_no character varying(50) NOT NULL,
    date date DEFAULT CURRENT_DATE,
    account_id integer,
    type character varying(3),
    amount numeric(15,2),
    currency character varying(10),
    counterparty_type character varying(20),
    counterparty_id integer,
    memo text,
    so_id integer,
    po_id integer,
    created_by integer,
    CONSTRAINT cashbooks_counterparty_type_check CHECK (((counterparty_type)::text = ANY (ARRAY[('CUSTOMER'::character varying)::text, ('SUPPLIER'::character varying)::text, ('OTHER'::character varying)::text]))),
    CONSTRAINT cashbooks_type_check CHECK (((type)::text = ANY (ARRAY[('IN'::character varying)::text, ('OUT'::character varying)::text])))
);


ALTER TABLE ke_toan_tien.cashbooks OWNER TO postgres;

--
-- Name: cashbooks_id_seq; Type: SEQUENCE; Schema: ke_toan_tien; Owner: postgres
--

CREATE SEQUENCE ke_toan_tien.cashbooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ke_toan_tien.cashbooks_id_seq OWNER TO postgres;

--
-- Name: cashbooks_id_seq; Type: SEQUENCE OWNED BY; Schema: ke_toan_tien; Owner: postgres
--

ALTER SEQUENCE ke_toan_tien.cashbooks_id_seq OWNED BY ke_toan_tien.cashbooks.id;


--
-- Name: payments; Type: TABLE; Schema: ke_toan_tien; Owner: postgres
--

CREATE TABLE ke_toan_tien.payments (
    id integer NOT NULL,
    pay_no character varying(50) NOT NULL,
    date date DEFAULT CURRENT_DATE,
    from_account_id integer,
    to_type character varying(20),
    to_id integer,
    amount numeric(15,2),
    currency character varying(10),
    method character varying(50),
    ref_doc character varying(50),
    notes text,
    CONSTRAINT payments_ref_doc_check CHECK (((ref_doc)::text = ANY (ARRAY[('invoice'::character varying)::text, ('bill'::character varying)::text]))),
    CONSTRAINT payments_to_type_check CHECK (((to_type)::text = ANY (ARRAY[('CUSTOMER'::character varying)::text, ('SUPPLIER'::character varying)::text, ('OTHER'::character varying)::text])))
);


ALTER TABLE ke_toan_tien.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: ke_toan_tien; Owner: postgres
--

CREATE SEQUENCE ke_toan_tien.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ke_toan_tien.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: ke_toan_tien; Owner: postgres
--

ALTER SEQUENCE ke_toan_tien.payments_id_seq OWNED BY ke_toan_tien.payments.id;


--
-- Name: inventory_ledgers; Type: TABLE; Schema: kho_ton; Owner: postgres
--

CREATE TABLE kho_ton.inventory_ledgers (
    id integer NOT NULL,
    wh_id integer,
    product_variant_id integer,
    ref_type character varying(20),
    ref_id integer,
    qty_in integer DEFAULT 0,
    qty_out integer DEFAULT 0,
    balance_after integer,
    at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT inventory_ledgers_ref_type_check CHECK (((ref_type)::text = ANY (ARRAY[('GRN'::character varying)::text, ('DELIVERY'::character varying)::text, ('TRANSFER'::character varying)::text, ('ADJUST'::character varying)::text])))
);


ALTER TABLE kho_ton.inventory_ledgers OWNER TO postgres;

--
-- Name: inventory_ledgers_id_seq; Type: SEQUENCE; Schema: kho_ton; Owner: postgres
--

CREATE SEQUENCE kho_ton.inventory_ledgers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE kho_ton.inventory_ledgers_id_seq OWNER TO postgres;

--
-- Name: inventory_ledgers_id_seq; Type: SEQUENCE OWNED BY; Schema: kho_ton; Owner: postgres
--

ALTER SEQUENCE kho_ton.inventory_ledgers_id_seq OWNED BY kho_ton.inventory_ledgers.id;


--
-- Name: stock_transfer_items; Type: TABLE; Schema: kho_ton; Owner: postgres
--

CREATE TABLE kho_ton.stock_transfer_items (
    id integer NOT NULL,
    transfer_id integer,
    product_variant_id integer,
    qty integer
);


ALTER TABLE kho_ton.stock_transfer_items OWNER TO postgres;

--
-- Name: stock_transfer_items_id_seq; Type: SEQUENCE; Schema: kho_ton; Owner: postgres
--

CREATE SEQUENCE kho_ton.stock_transfer_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE kho_ton.stock_transfer_items_id_seq OWNER TO postgres;

--
-- Name: stock_transfer_items_id_seq; Type: SEQUENCE OWNED BY; Schema: kho_ton; Owner: postgres
--

ALTER SEQUENCE kho_ton.stock_transfer_items_id_seq OWNED BY kho_ton.stock_transfer_items.id;


--
-- Name: stock_transfers; Type: TABLE; Schema: kho_ton; Owner: postgres
--

CREATE TABLE kho_ton.stock_transfers (
    id integer NOT NULL,
    from_wh_id integer,
    to_wh_id integer,
    transfer_no character varying(50) NOT NULL,
    date date DEFAULT CURRENT_DATE,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT stock_transfers_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('COMPLETED'::character varying)::text])))
);


ALTER TABLE kho_ton.stock_transfers OWNER TO postgres;

--
-- Name: stock_transfers_id_seq; Type: SEQUENCE; Schema: kho_ton; Owner: postgres
--

CREATE SEQUENCE kho_ton.stock_transfers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE kho_ton.stock_transfers_id_seq OWNER TO postgres;

--
-- Name: stock_transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: kho_ton; Owner: postgres
--

ALTER SEQUENCE kho_ton.stock_transfers_id_seq OWNED BY kho_ton.stock_transfers.id;


--
-- Name: sample_changes; Type: TABLE; Schema: mau_custom; Owner: postgres
--

CREATE TABLE mau_custom.sample_changes (
    id integer NOT NULL,
    sample_id integer,
    rev_no integer,
    date_reported date DEFAULT CURRENT_DATE,
    change_desc text,
    supplier_can_do boolean,
    reason_if_not text,
    photos integer[]
);


ALTER TABLE mau_custom.sample_changes OWNER TO postgres;

--
-- Name: sample_changes_id_seq; Type: SEQUENCE; Schema: mau_custom; Owner: postgres
--

CREATE SEQUENCE mau_custom.sample_changes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mau_custom.sample_changes_id_seq OWNER TO postgres;

--
-- Name: sample_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: mau_custom; Owner: postgres
--

ALTER SEQUENCE mau_custom.sample_changes_id_seq OWNED BY mau_custom.sample_changes.id;


--
-- Name: sample_outcome; Type: TABLE; Schema: mau_custom; Owner: postgres
--

CREATE TABLE mau_custom.sample_outcome (
    id integer NOT NULL,
    sample_id integer,
    locked boolean DEFAULT false,
    customer_decision character varying(20) DEFAULT 'PENDING'::character varying,
    reason text,
    CONSTRAINT sample_outcome_customer_decision_check CHECK (((customer_decision)::text = ANY (ARRAY[('YES'::character varying)::text, ('NO'::character varying)::text, ('PENDING'::character varying)::text])))
);


ALTER TABLE mau_custom.sample_outcome OWNER TO postgres;

--
-- Name: sample_outcome_id_seq; Type: SEQUENCE; Schema: mau_custom; Owner: postgres
--

CREATE SEQUENCE mau_custom.sample_outcome_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mau_custom.sample_outcome_id_seq OWNER TO postgres;

--
-- Name: sample_outcome_id_seq; Type: SEQUENCE OWNED BY; Schema: mau_custom; Owner: postgres
--

ALTER SEQUENCE mau_custom.sample_outcome_id_seq OWNED BY mau_custom.sample_outcome.id;


--
-- Name: samples; Type: TABLE; Schema: mau_custom; Owner: postgres
--

CREATE TABLE mau_custom.samples (
    id integer NOT NULL,
    customer_id integer,
    supplier_id integer,
    product_ref character varying(255),
    spec_json jsonb,
    sample_cost numeric(15,2),
    deposit numeric(15,2),
    refundable_rules text,
    photos integer[],
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT samples_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('APPROVED'::character varying)::text, ('REJECTED'::character varying)::text])))
);


ALTER TABLE mau_custom.samples OWNER TO postgres;

--
-- Name: samples_id_seq; Type: SEQUENCE; Schema: mau_custom; Owner: postgres
--

CREATE SEQUENCE mau_custom.samples_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mau_custom.samples_id_seq OWNER TO postgres;

--
-- Name: samples_id_seq; Type: SEQUENCE OWNED BY; Schema: mau_custom; Owner: postgres
--

ALTER SEQUENCE mau_custom.samples_id_seq OWNED BY mau_custom.samples.id;


--
-- Name: grn_items; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.grn_items (
    id integer NOT NULL,
    grn_id integer,
    po_item_id integer,
    qty_ordered integer,
    qty_received integer,
    diff integer,
    remarks text,
    signer integer
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.grn_items OWNER TO postgres;

--
-- Name: grn_items_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.grn_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.grn_items_id_seq OWNER TO postgres;

--
-- Name: grn_items_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.grn_items_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.grn_items.id;


--
-- Name: grns; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.grns (
    id integer NOT NULL,
    po_id integer,
    wh_id integer,
    grn_no character varying(50) NOT NULL,
    checked_by integer,
    checked_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.grns OWNER TO postgres;

--
-- Name: grns_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.grns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.grns_id_seq OWNER TO postgres;

--
-- Name: grns_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.grns_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.grns.id;


--
-- Name: inbound_shipments; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.inbound_shipments (
    id integer NOT NULL,
    po_id integer,
    leg character varying(50),
    ship_no character varying(50),
    depart_at date,
    arrive_est date,
    arrive_actual date,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT inbound_shipments_leg_check CHECK (((leg)::text = ANY (ARRAY[('SUPPLIER→FWDR'::character varying)::text, ('FWDR→VN'::character varying)::text]))),
    CONSTRAINT inbound_shipments_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('ARRIVED'::character varying)::text, ('IN_TRANSIT'::character varying)::text])))
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.inbound_shipments OWNER TO postgres;

--
-- Name: inbound_shipments_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.inbound_shipments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.inbound_shipments_id_seq OWNER TO postgres;

--
-- Name: inbound_shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.inbound_shipments_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.inbound_shipments.id;


--
-- Name: po_items; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.po_items (
    id integer NOT NULL,
    po_id integer,
    product_variant_id integer,
    img_file_id integer,
    qty integer,
    unit_cost numeric(10,2),
    amount numeric(10,2)
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.po_items OWNER TO postgres;

--
-- Name: po_items_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.po_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.po_items_id_seq OWNER TO postgres;

--
-- Name: po_items_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.po_items_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.po_items.id;


--
-- Name: purchase_orders; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.purchase_orders (
    id integer NOT NULL,
    supplier_id integer,
    po_no character varying(50) NOT NULL,
    order_date date DEFAULT CURRENT_DATE,
    currency character varying(10),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    ship_route jsonb,
    notes text,
    CONSTRAINT purchase_orders_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('COMPLETED'::character varying)::text])))
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.purchase_orders OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.purchase_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.purchase_orders_id_seq OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.purchase_orders_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.purchase_orders.id;


--
-- Name: qc_checks; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.qc_checks (
    id integer NOT NULL,
    grn_item_id integer,
    result character varying(10),
    photos integer[],
    notes text,
    CONSTRAINT qc_checks_result_check CHECK (((result)::text = ANY (ARRAY[('PASS'::character varying)::text, ('FAIL'::character varying)::text])))
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.qc_checks OWNER TO postgres;

--
-- Name: qc_checks_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.qc_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.qc_checks_id_seq OWNER TO postgres;

--
-- Name: qc_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.qc_checks_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.qc_checks.id;


--
-- Name: tag_sewing_batches; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.tag_sewing_batches (
    id integer NOT NULL,
    so_id integer,
    date_in date DEFAULT CURRENT_DATE,
    charge_user integer,
    signer integer
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.tag_sewing_batches OWNER TO postgres;

--
-- Name: tag_sewing_batches_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.tag_sewing_batches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.tag_sewing_batches_id_seq OWNER TO postgres;

--
-- Name: tag_sewing_batches_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.tag_sewing_batches_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.tag_sewing_batches.id;


--
-- Name: tag_sewing_items; Type: TABLE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE TABLE mua_hang_nhap_kho_qc_tag.tag_sewing_items (
    id integer NOT NULL,
    batch_id integer,
    product_variant_id integer,
    qty integer
);


ALTER TABLE mua_hang_nhap_kho_qc_tag.tag_sewing_items OWNER TO postgres;

--
-- Name: tag_sewing_items_id_seq; Type: SEQUENCE; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

CREATE SEQUENCE mua_hang_nhap_kho_qc_tag.tag_sewing_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.tag_sewing_items_id_seq OWNER TO postgres;

--
-- Name: tag_sewing_items_id_seq; Type: SEQUENCE OWNED BY; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER SEQUENCE mua_hang_nhap_kho_qc_tag.tag_sewing_items_id_seq OWNED BY mua_hang_nhap_kho_qc_tag.tag_sewing_items.id;


--
-- Name: supplier_contacts; Type: TABLE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE TABLE nha_cung_cap_soi.supplier_contacts (
    id integer NOT NULL,
    supplier_id integer,
    contact_name character varying(255),
    phone character varying(20),
    wechat character varying(50),
    notes text
);


ALTER TABLE nha_cung_cap_soi.supplier_contacts OWNER TO postgres;

--
-- Name: supplier_contacts_id_seq; Type: SEQUENCE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE SEQUENCE nha_cung_cap_soi.supplier_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nha_cung_cap_soi.supplier_contacts_id_seq OWNER TO postgres;

--
-- Name: supplier_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER SEQUENCE nha_cung_cap_soi.supplier_contacts_id_seq OWNED BY nha_cung_cap_soi.supplier_contacts.id;


--
-- Name: suppliers; Type: TABLE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE TABLE nha_cung_cap_soi.suppliers (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    nickname character varying(255),
    product_lines text,
    current_ap_total_purchased numeric(10,2)
);


ALTER TABLE nha_cung_cap_soi.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE SEQUENCE nha_cung_cap_soi.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nha_cung_cap_soi.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER SEQUENCE nha_cung_cap_soi.suppliers_id_seq OWNED BY nha_cung_cap_soi.suppliers.id;


--
-- Name: yarn_color_cards; Type: TABLE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE TABLE nha_cung_cap_soi.yarn_color_cards (
    id integer NOT NULL,
    yarn_id integer,
    card_type character varying(50),
    id_img_file_id integer
);


ALTER TABLE nha_cung_cap_soi.yarn_color_cards OWNER TO postgres;

--
-- Name: yarn_color_cards_id_seq; Type: SEQUENCE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE SEQUENCE nha_cung_cap_soi.yarn_color_cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nha_cung_cap_soi.yarn_color_cards_id_seq OWNER TO postgres;

--
-- Name: yarn_color_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER SEQUENCE nha_cung_cap_soi.yarn_color_cards_id_seq OWNED BY nha_cung_cap_soi.yarn_color_cards.id;


--
-- Name: yarn_colors; Type: TABLE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE TABLE nha_cung_cap_soi.yarn_colors (
    id integer NOT NULL,
    yarn_card_id integer,
    color_name character varying(255),
    color_no character varying(50),
    remarks text
);


ALTER TABLE nha_cung_cap_soi.yarn_colors OWNER TO postgres;

--
-- Name: yarn_colors_id_seq; Type: SEQUENCE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE SEQUENCE nha_cung_cap_soi.yarn_colors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nha_cung_cap_soi.yarn_colors_id_seq OWNER TO postgres;

--
-- Name: yarn_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER SEQUENCE nha_cung_cap_soi.yarn_colors_id_seq OWNED BY nha_cung_cap_soi.yarn_colors.id;


--
-- Name: yarns; Type: TABLE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE TABLE nha_cung_cap_soi.yarns (
    id integer NOT NULL,
    supplier_id integer,
    blend_json jsonb,
    notes text
);


ALTER TABLE nha_cung_cap_soi.yarns OWNER TO postgres;

--
-- Name: yarns_id_seq; Type: SEQUENCE; Schema: nha_cung_cap_soi; Owner: postgres
--

CREATE SEQUENCE nha_cung_cap_soi.yarns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nha_cung_cap_soi.yarns_id_seq OWNER TO postgres;

--
-- Name: yarns_id_seq; Type: SEQUENCE OWNED BY; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER SEQUENCE nha_cung_cap_soi.yarns_id_seq OWNED BY nha_cung_cap_soi.yarns.id;


--
-- Name: employee_roles; Type: TABLE; Schema: nhan_su; Owner: postgres
--

CREATE TABLE nhan_su.employee_roles (
    id integer NOT NULL,
    employee_id integer,
    role_id integer,
    department_id integer
);


ALTER TABLE nhan_su.employee_roles OWNER TO postgres;

--
-- Name: employee_roles_id_seq; Type: SEQUENCE; Schema: nhan_su; Owner: postgres
--

CREATE SEQUENCE nhan_su.employee_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nhan_su.employee_roles_id_seq OWNER TO postgres;

--
-- Name: employee_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: nhan_su; Owner: postgres
--

ALTER SEQUENCE nhan_su.employee_roles_id_seq OWNED BY nhan_su.employee_roles.id;


--
-- Name: employees; Type: TABLE; Schema: nhan_su; Owner: postgres
--

CREATE TABLE nhan_su.employees (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    dob date,
    phone character varying(20),
    address text,
    tax_no character varying(50),
    bank_info jsonb,
    joined_date date,
    seniority_years integer,
    cv_file_id integer,
    total_salary_paid numeric(15,2)
);


ALTER TABLE nhan_su.employees OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: nhan_su; Owner: postgres
--

CREATE SEQUENCE nhan_su.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nhan_su.employees_id_seq OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: nhan_su; Owner: postgres
--

ALTER SEQUENCE nhan_su.employees_id_seq OWNED BY nhan_su.employees.id;


--
-- Name: payroll_records; Type: TABLE; Schema: nhan_su; Owner: postgres
--

CREATE TABLE nhan_su.payroll_records (
    id integer NOT NULL,
    employee_id integer,
    month date,
    gross numeric(15,2),
    net numeric(15,2),
    paid_at date,
    notes text
);


ALTER TABLE nhan_su.payroll_records OWNER TO postgres;

--
-- Name: payroll_records_id_seq; Type: SEQUENCE; Schema: nhan_su; Owner: postgres
--

CREATE SEQUENCE nhan_su.payroll_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE nhan_su.payroll_records_id_seq OWNER TO postgres;

--
-- Name: payroll_records_id_seq; Type: SEQUENCE OWNED BY; Schema: nhan_su; Owner: postgres
--

ALTER SEQUENCE nhan_su.payroll_records_id_seq OWNED BY nhan_su.payroll_records.id;


--
-- Name: product_images; Type: TABLE; Schema: san_pham; Owner: postgres
--

CREATE TABLE san_pham.product_images (
    id integer NOT NULL,
    product_id integer,
    file_id integer,
    sort integer
);


ALTER TABLE san_pham.product_images OWNER TO postgres;

--
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: san_pham; Owner: postgres
--

CREATE SEQUENCE san_pham.product_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE san_pham.product_images_id_seq OWNER TO postgres;

--
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: san_pham; Owner: postgres
--

ALTER SEQUENCE san_pham.product_images_id_seq OWNED BY san_pham.product_images.id;


--
-- Name: product_supplier_map; Type: TABLE; Schema: san_pham; Owner: postgres
--

CREATE TABLE san_pham.product_supplier_map (
    id integer NOT NULL,
    product_id integer,
    supplier_id integer,
    default_cost numeric(10,2),
    currency character varying(10),
    lead_time_days integer
);


ALTER TABLE san_pham.product_supplier_map OWNER TO postgres;

--
-- Name: product_supplier_map_id_seq; Type: SEQUENCE; Schema: san_pham; Owner: postgres
--

CREATE SEQUENCE san_pham.product_supplier_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE san_pham.product_supplier_map_id_seq OWNER TO postgres;

--
-- Name: product_supplier_map_id_seq; Type: SEQUENCE OWNED BY; Schema: san_pham; Owner: postgres
--

ALTER SEQUENCE san_pham.product_supplier_map_id_seq OWNED BY san_pham.product_supplier_map.id;


--
-- Name: product_variants; Type: TABLE; Schema: san_pham; Owner: postgres
--

CREATE TABLE san_pham.product_variants (
    id integer NOT NULL,
    product_id integer,
    sku character varying(50) NOT NULL,
    size character varying(50),
    color character varying(50),
    barcode character varying(50)
);


ALTER TABLE san_pham.product_variants OWNER TO postgres;

--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: san_pham; Owner: postgres
--

CREATE SEQUENCE san_pham.product_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE san_pham.product_variants_id_seq OWNER TO postgres;

--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: san_pham; Owner: postgres
--

ALTER SEQUENCE san_pham.product_variants_id_seq OWNED BY san_pham.product_variants.id;


--
-- Name: products; Type: TABLE; Schema: san_pham; Owner: postgres
--

CREATE TABLE san_pham.products (
    id integer NOT NULL,
    supplier_item_code character varying(50),
    our_code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(50),
    fiber_spec jsonb,
    min_price numeric(10,2),
    images integer[],
    status boolean DEFAULT true
);


ALTER TABLE san_pham.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: san_pham; Owner: postgres
--

CREATE SEQUENCE san_pham.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE san_pham.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: san_pham; Owner: postgres
--

ALTER SEQUENCE san_pham.products_id_seq OWNED BY san_pham.products.id;


--
-- Name: activity_logs; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.activity_logs (
    id integer NOT NULL,
    object_type character varying(50),
    object_id integer,
    action character varying(255),
    by_user integer,
    at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE system.activity_logs OWNER TO postgres;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.activity_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE system.activity_logs_id_seq OWNER TO postgres;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.activity_logs_id_seq OWNED BY system.activity_logs.id;


--
-- Name: departments; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.departments (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE system.departments OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE system.departments_id_seq OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.departments_id_seq OWNED BY system.departments.id;


--
-- Name: files; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.files (
    id integer NOT NULL,
    object_type character varying(50),
    object_id integer,
    file_path text NOT NULL,
    caption text,
    uploaded_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE system.files OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE system.files_id_seq OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.files_id_seq OWNED BY system.files.id;


--
-- Name: roles; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions jsonb
);


ALTER TABLE system.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE system.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.roles_id_seq OWNED BY system.roles.id;


--
-- Name: users; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.users (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    phone character varying(20),
    email character varying(255) NOT NULL,
    role_id integer,
    status boolean DEFAULT true,
    password_hash text NOT NULL
);


ALTER TABLE system.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE system.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.users_id_seq OWNED BY system.users.id;


--
-- Name: warehouses; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.warehouses (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    address text
);


ALTER TABLE system.warehouses OWNER TO postgres;

--
-- Name: warehouses_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.warehouses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE system.warehouses_id_seq OWNER TO postgres;

--
-- Name: warehouses_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.warehouses_id_seq OWNED BY system.warehouses.id;


--
-- Name: deliveries id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.deliveries ALTER COLUMN id SET DEFAULT nextval('ban_hang.deliveries_id_seq'::regclass);


--
-- Name: delivery_items id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.delivery_items ALTER COLUMN id SET DEFAULT nextval('ban_hang.delivery_items_id_seq'::regclass);


--
-- Name: estimate_items id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimate_items ALTER COLUMN id SET DEFAULT nextval('ban_hang.estimate_items_id_seq'::regclass);


--
-- Name: estimates id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimates ALTER COLUMN id SET DEFAULT nextval('ban_hang.estimates_id_seq'::regclass);


--
-- Name: sales_order_items id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_order_items ALTER COLUMN id SET DEFAULT nextval('ban_hang.sales_order_items_id_seq'::regclass);


--
-- Name: sales_orders id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_orders ALTER COLUMN id SET DEFAULT nextval('ban_hang.sales_orders_id_seq'::regclass);


--
-- Name: so_settlements id; Type: DEFAULT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.so_settlements ALTER COLUMN id SET DEFAULT nextval('ban_hang.so_settlements_id_seq'::regclass);


--
-- Name: crm_leads id; Type: DEFAULT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.crm_leads ALTER COLUMN id SET DEFAULT nextval('crm_khach_hang.crm_leads_id_seq'::regclass);


--
-- Name: customer_banks id; Type: DEFAULT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_banks ALTER COLUMN id SET DEFAULT nextval('crm_khach_hang.customer_banks_id_seq'::regclass);


--
-- Name: customer_interest id; Type: DEFAULT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_interest ALTER COLUMN id SET DEFAULT nextval('crm_khach_hang.customer_interest_id_seq'::regclass);


--
-- Name: customer_price_history id; Type: DEFAULT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_price_history ALTER COLUMN id SET DEFAULT nextval('crm_khach_hang.customer_price_history_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customers ALTER COLUMN id SET DEFAULT nextval('crm_khach_hang.customers_id_seq'::regclass);


--
-- Name: ap_bills id; Type: DEFAULT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ap_bills ALTER COLUMN id SET DEFAULT nextval('ke_toan_tien.ap_bills_id_seq'::regclass);


--
-- Name: ar_invoices id; Type: DEFAULT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ar_invoices ALTER COLUMN id SET DEFAULT nextval('ke_toan_tien.ar_invoices_id_seq'::regclass);


--
-- Name: balances_daily id; Type: DEFAULT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.balances_daily ALTER COLUMN id SET DEFAULT nextval('ke_toan_tien.balances_daily_id_seq'::regclass);


--
-- Name: bank_accounts id; Type: DEFAULT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.bank_accounts ALTER COLUMN id SET DEFAULT nextval('ke_toan_tien.bank_accounts_id_seq'::regclass);


--
-- Name: cashbooks id; Type: DEFAULT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks ALTER COLUMN id SET DEFAULT nextval('ke_toan_tien.cashbooks_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.payments ALTER COLUMN id SET DEFAULT nextval('ke_toan_tien.payments_id_seq'::regclass);


--
-- Name: inventory_ledgers id; Type: DEFAULT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.inventory_ledgers ALTER COLUMN id SET DEFAULT nextval('kho_ton.inventory_ledgers_id_seq'::regclass);


--
-- Name: stock_transfer_items id; Type: DEFAULT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfer_items ALTER COLUMN id SET DEFAULT nextval('kho_ton.stock_transfer_items_id_seq'::regclass);


--
-- Name: stock_transfers id; Type: DEFAULT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfers ALTER COLUMN id SET DEFAULT nextval('kho_ton.stock_transfers_id_seq'::regclass);


--
-- Name: sample_changes id; Type: DEFAULT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.sample_changes ALTER COLUMN id SET DEFAULT nextval('mau_custom.sample_changes_id_seq'::regclass);


--
-- Name: sample_outcome id; Type: DEFAULT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.sample_outcome ALTER COLUMN id SET DEFAULT nextval('mau_custom.sample_outcome_id_seq'::regclass);


--
-- Name: samples id; Type: DEFAULT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.samples ALTER COLUMN id SET DEFAULT nextval('mau_custom.samples_id_seq'::regclass);


--
-- Name: grn_items id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grn_items ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.grn_items_id_seq'::regclass);


--
-- Name: grns id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grns ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.grns_id_seq'::regclass);


--
-- Name: inbound_shipments id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.inbound_shipments ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.inbound_shipments_id_seq'::regclass);


--
-- Name: po_items id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.po_items ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.po_items_id_seq'::regclass);


--
-- Name: purchase_orders id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.purchase_orders ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.purchase_orders_id_seq'::regclass);


--
-- Name: qc_checks id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.qc_checks ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.qc_checks_id_seq'::regclass);


--
-- Name: tag_sewing_batches id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_batches ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.tag_sewing_batches_id_seq'::regclass);


--
-- Name: tag_sewing_items id; Type: DEFAULT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_items ALTER COLUMN id SET DEFAULT nextval('mua_hang_nhap_kho_qc_tag.tag_sewing_items_id_seq'::regclass);


--
-- Name: supplier_contacts id; Type: DEFAULT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.supplier_contacts ALTER COLUMN id SET DEFAULT nextval('nha_cung_cap_soi.supplier_contacts_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.suppliers ALTER COLUMN id SET DEFAULT nextval('nha_cung_cap_soi.suppliers_id_seq'::regclass);


--
-- Name: yarn_color_cards id; Type: DEFAULT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_color_cards ALTER COLUMN id SET DEFAULT nextval('nha_cung_cap_soi.yarn_color_cards_id_seq'::regclass);


--
-- Name: yarn_colors id; Type: DEFAULT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_colors ALTER COLUMN id SET DEFAULT nextval('nha_cung_cap_soi.yarn_colors_id_seq'::regclass);


--
-- Name: yarns id; Type: DEFAULT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarns ALTER COLUMN id SET DEFAULT nextval('nha_cung_cap_soi.yarns_id_seq'::regclass);


--
-- Name: employee_roles id; Type: DEFAULT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employee_roles ALTER COLUMN id SET DEFAULT nextval('nhan_su.employee_roles_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employees ALTER COLUMN id SET DEFAULT nextval('nhan_su.employees_id_seq'::regclass);


--
-- Name: payroll_records id; Type: DEFAULT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.payroll_records ALTER COLUMN id SET DEFAULT nextval('nhan_su.payroll_records_id_seq'::regclass);


--
-- Name: product_images id; Type: DEFAULT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_images ALTER COLUMN id SET DEFAULT nextval('san_pham.product_images_id_seq'::regclass);


--
-- Name: product_supplier_map id; Type: DEFAULT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_supplier_map ALTER COLUMN id SET DEFAULT nextval('san_pham.product_supplier_map_id_seq'::regclass);


--
-- Name: product_variants id; Type: DEFAULT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_variants ALTER COLUMN id SET DEFAULT nextval('san_pham.product_variants_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.products ALTER COLUMN id SET DEFAULT nextval('san_pham.products_id_seq'::regclass);


--
-- Name: activity_logs id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.activity_logs ALTER COLUMN id SET DEFAULT nextval('system.activity_logs_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.departments ALTER COLUMN id SET DEFAULT nextval('system.departments_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.files ALTER COLUMN id SET DEFAULT nextval('system.files_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.roles ALTER COLUMN id SET DEFAULT nextval('system.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.users ALTER COLUMN id SET DEFAULT nextval('system.users_id_seq'::regclass);


--
-- Name: warehouses id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.warehouses ALTER COLUMN id SET DEFAULT nextval('system.warehouses_id_seq'::regclass);


--
-- Data for Name: deliveries; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.deliveries (id, so_id, wh_id, delivery_no, delivery_date, status) FROM stdin;
1	1	1	DEL12345	2023-06-05	PENDING
2	2	2	DEL12346	2023-06-08	PENDING
3	3	1	DEL12347	2023-06-15	PENDING
\.


--
-- Data for Name: delivery_items; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.delivery_items (id, delivery_id, so_item_id, qty_delivered_actual) FROM stdin;
1	1	1	5
2	1	2	3
3	2	3	2
4	3	4	6
\.


--
-- Data for Name: estimate_items; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.estimate_items (id, estimate_id, product_variant_id, qty, unit_price, discount, amount) FROM stdin;
1	1	1	5	100000.00	5000.00	475000.00
2	1	2	3	80000.00	2000.00	234000.00
3	2	3	2	150000.00	10000.00	280000.00
4	3	1	6	120000.00	10000.00	660000.00
\.


--
-- Data for Name: estimates; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.estimates (id, customer_id, est_no, version, est_date, valid_until, currency, total, notes, visible_to_customer) FROM stdin;
1	1	EST12345	1	2023-06-01	2023-06-30	VND	500000.00	Báo giá cho khách hàng ABC	t
2	2	EST12346	1	2023-06-05	2023-07-05	VND	300000.00	Báo giá cho khách hàng XYZ	f
3	3	EST12347	1	2023-06-10	2023-07-10	VND	700000.00	Báo giá cho khách hàng LMN	t
\.


--
-- Data for Name: sales_order_items; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.sales_order_items (id, so_id, product_variant_id, qty_ordered, unit_price, discount, amount, currency, image_file_id) FROM stdin;
1	1	1	5	100000.00	5000.00	475000.00	VND	1
2	1	2	3	80000.00	2000.00	234000.00	VND	2
3	2	3	2	150000.00	10000.00	280000.00	VND	3
4	3	1	6	120000.00	10000.00	660000.00	VND	4
\.


--
-- Data for Name: sales_orders; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.sales_orders (id, customer_id, so_no, from_estimate_id, order_date, promised_dates, status, deposit_amount, deposit_percent, currency, totals) FROM stdin;
1	1	SO12345	1	2023-06-01	{"L1": "2023-06-05", "L2": "2023-06-10", "L3": "2023-06-15"}	NEW	100000.00	20.00	VND	{"expected_total": 500000}
2	2	SO12346	2	2023-06-05	{"L1": "2023-06-08", "L2": "2023-06-12", "L3": "2023-06-15"}	PARTIAL	50000.00	10.00	VND	{"expected_total": 300000}
3	3	SO12347	3	2023-06-10	{"L1": "2023-06-15", "L2": "2023-06-20", "L3": "2023-06-25"}	FULL	140000.00	20.00	VND	{"expected_total": 700000}
\.


--
-- Data for Name: so_settlements; Type: TABLE DATA; Schema: ban_hang; Owner: postgres
--

COPY ban_hang.so_settlements (id, so_id, amount, reason, settled_at) FROM stdin;
1	1	100000.00	Đặt cọc	2023-06-01 00:00:00
2	2	50000.00	Đặt cọc	2023-06-05 00:00:00
3	3	140000.00	Đặt cọc	2023-06-10 00:00:00
\.


--
-- Data for Name: crm_leads; Type: TABLE DATA; Schema: crm_khach_hang; Owner: postgres
--

COPY crm_khach_hang.crm_leads (id, customer_id, source, stage, reason_win, reason_lose, journey_notes) FROM stdin;
1	1	Tìm kiếm online	CONTACTED	Giá cả hợp lý	Chưa có đủ thông tin	Khách hàng đã yêu cầu báo giá
2	2	Giới thiệu từ đối tác	NEGOTIATION	Sản phẩm chất lượng	Không đáp ứng được thời gian giao hàng	Đã gửi mẫu sản phẩm và đợi phản hồi
3	3	Hội nghị triển lãm	NEW	Chất lượng sản phẩm	Chưa quyết định	Khách hàng đang so sánh với nhà cung cấp khác
\.


--
-- Data for Name: customer_banks; Type: TABLE DATA; Schema: crm_khach_hang; Owner: postgres
--

COPY crm_khach_hang.customer_banks (id, customer_id, bank_name, account_no, owner, qr_file_id) FROM stdin;
1	1	Ngân hàng A	1234567890	Công ty ABC	1
2	2	Ngân hàng B	0987654321	Công ty XYZ	2
3	3	Ngân hàng C	1122334455	Công ty LMN	3
\.


--
-- Data for Name: customer_interest; Type: TABLE DATA; Schema: crm_khach_hang; Owner: postgres
--

COPY crm_khach_hang.customer_interest (id, customer_id, product_category, tags, notes) FROM stdin;
1	1	Sợi vải	["Cotton", "Polyester"]	Quan tâm đến các loại sợi vải cao cấp
2	2	Sản phẩm may mặc	["Quần áo", "Áo thun"]	Mong muốn hợp tác lâu dài
3	3	Nguyên liệu sản xuất	["Sợi", "Vải", "Polyester"]	Đang tìm kiếm nhà cung cấp ổn định
\.


--
-- Data for Name: customer_price_history; Type: TABLE DATA; Schema: crm_khach_hang; Owner: postgres
--

COPY crm_khach_hang.customer_price_history (id, customer_id, product_id, price, currency, valid_from, valid_to) FROM stdin;
1	1	1	200.00	VND	2023-01-01	2023-12-31
2	2	2	150.00	VND	2023-02-01	2023-12-31
3	3	3	180.00	VND	2023-03-01	2023-12-31
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: crm_khach_hang; Owner: postgres
--

COPY crm_khach_hang.customers (id, code, name, phone, addresses, tax_code, notes) FROM stdin;
1	C001	Công ty ABC	0901234567	{"address_1": "123 Đường ABC, Hà Nội", "address_2": "Tầng 5, Tòa nhà XYZ"}	123456789	Khách hàng thân thiết
2	C002	Công ty XYZ	0902345678	{"address_1": "456 Đường DEF, TP.HCM"}	987654321	Mới mua hàng lần đầu
3	C003	Công ty LMN	0903456789	{"address_1": "789 Đường GHI, Hà Nội", "address_2": "Tầng 2, Tòa nhà 123"}	112233445	Khách hàng tiềm năng
\.


--
-- Data for Name: ap_bills; Type: TABLE DATA; Schema: ke_toan_tien; Owner: postgres
--

COPY ke_toan_tien.ap_bills (id, po_id, bill_no, date, due_date, amount, currency, status) FROM stdin;
1	1	BILL12345	2023-06-05	2023-06-15	300000.00	VND	PENDING
2	2	BILL12346	2023-06-10	2023-06-20	150000.00	VND	PAID
3	3	BILL12347	2023-06-15	2023-06-25	600000.00	VND	PENDING
\.


--
-- Data for Name: ar_invoices; Type: TABLE DATA; Schema: ke_toan_tien; Owner: postgres
--

COPY ke_toan_tien.ar_invoices (id, so_id, invoice_no, date, due_date, amount, currency, status) FROM stdin;
1	1	INV12345	2023-06-05	2023-06-15	500000.00	VND	PENDING
2	2	INV12346	2023-06-10	2023-06-20	300000.00	VND	PAID
3	3	INV12347	2023-06-15	2023-06-25	700000.00	VND	PENDING
\.


--
-- Data for Name: balances_daily; Type: TABLE DATA; Schema: ke_toan_tien; Owner: postgres
--

COPY ke_toan_tien.balances_daily (id, as_of_date, bank_account_id, balance_ar_total, ap_total) FROM stdin;
1	2023-06-01	1	500000.00	200000.00
2	2023-06-05	2	300000.00	150000.00
3	2023-06-10	3	700000.00	300000.00
\.


--
-- Data for Name: bank_accounts; Type: TABLE DATA; Schema: ke_toan_tien; Owner: postgres
--

COPY ke_toan_tien.bank_accounts (id, name, bank_name, account_no, owner, qr_file_id, currency, opening_balance) FROM stdin;
1	Tài khoản công ty A	Ngân hàng A	1234567890	Công ty A	\N	VND	10000000.00
2	Tài khoản công ty B	Ngân hàng B	0987654321	Công ty B	\N	VND	5000000.00
3	Tài khoản công ty C	Ngân hàng C	1122334455	Công ty C	\N	USD	2000.00
\.


--
-- Data for Name: cashbooks; Type: TABLE DATA; Schema: ke_toan_tien; Owner: postgres
--

COPY ke_toan_tien.cashbooks (id, tx_no, date, account_id, type, amount, currency, counterparty_type, counterparty_id, memo, so_id, po_id, created_by) FROM stdin;
1	TX12345	2023-06-05	1	IN	100000.00	VND	CUSTOMER	1	Thanh toán từ khách hàng A	1	\N	1
2	TX12346	2023-06-10	2	OUT	50000.00	VND	SUPPLIER	2	Thanh toán cho nhà cung cấp B	\N	2	2
3	TX12347	2023-06-15	3	IN	1000.00	USD	OTHER	\N	Chuyển tiền từ đối tác C	\N	\N	3
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: ke_toan_tien; Owner: postgres
--

COPY ke_toan_tien.payments (id, pay_no, date, from_account_id, to_type, to_id, amount, currency, method, ref_doc, notes) FROM stdin;
1	PAY12345	2023-06-05	1	CUSTOMER	1	100000.00	VND	TRANSFER	invoice	Thanh toán hóa đơn từ khách hàng A
2	PAY12346	2023-06-10	2	SUPPLIER	2	50000.00	VND	CASH	bill	Thanh toán hóa đơn cho nhà cung cấp B
3	PAY12347	2023-06-15	3	OTHER	\N	1000.00	USD	TRANSFER	invoice	Chuyển tiền cho đối tác C
\.


--
-- Data for Name: inventory_ledgers; Type: TABLE DATA; Schema: kho_ton; Owner: postgres
--

COPY kho_ton.inventory_ledgers (id, wh_id, product_variant_id, ref_type, ref_id, qty_in, qty_out, balance_after, at) FROM stdin;
1	1	1	GRN	1	100	0	100	2023-06-01 00:00:00
2	1	2	DELIVERY	1	0	50	50	2023-06-05 00:00:00
3	2	3	TRANSFER	1	200	0	200	2023-06-08 00:00:00
4	2	1	ADJUST	2	0	10	190	2023-06-10 00:00:00
\.


--
-- Data for Name: stock_transfer_items; Type: TABLE DATA; Schema: kho_ton; Owner: postgres
--

COPY kho_ton.stock_transfer_items (id, transfer_id, product_variant_id, qty) FROM stdin;
1	1	1	100
2	1	2	150
3	2	3	200
4	3	1	50
\.


--
-- Data for Name: stock_transfers; Type: TABLE DATA; Schema: kho_ton; Owner: postgres
--

COPY kho_ton.stock_transfers (id, from_wh_id, to_wh_id, transfer_no, date, status) FROM stdin;
1	1	2	TRANSFER12345	2023-06-05	PENDING
2	2	1	TRANSFER12346	2023-06-10	COMPLETED
3	1	3	TRANSFER12347	2023-06-12	PENDING
\.


--
-- Data for Name: sample_changes; Type: TABLE DATA; Schema: mau_custom; Owner: postgres
--

COPY mau_custom.sample_changes (id, sample_id, rev_no, date_reported, change_desc, supplier_can_do, reason_if_not, photos) FROM stdin;
1	1	1	2023-06-01	Thêm chi tiết về chiều dài của sản phẩm	t	\N	{1,2}
2	2	1	2023-06-05	Cập nhật về chất liệu vải	f	Không thể cung cấp chất liệu như yêu cầu	{3,4}
3	3	1	2023-06-10	Thay đổi về màu sắc sản phẩm	t	\N	{5,6}
\.


--
-- Data for Name: sample_outcome; Type: TABLE DATA; Schema: mau_custom; Owner: postgres
--

COPY mau_custom.sample_outcome (id, sample_id, locked, customer_decision, reason) FROM stdin;
1	1	f	PENDING	Chờ phê duyệt từ khách hàng
2	2	t	YES	Mẫu được khách hàng phê duyệt
3	3	t	NO	Mẫu không đạt yêu cầu, khách hàng không đồng ý
\.


--
-- Data for Name: samples; Type: TABLE DATA; Schema: mau_custom; Owner: postgres
--

COPY mau_custom.samples (id, customer_id, supplier_id, product_ref, spec_json, sample_cost, deposit, refundable_rules, photos, status) FROM stdin;
1	1	1	SP001	{"width": "50cm", "length": "100cm", "material": "cotton"}	200000.00	50000.00	Refundable if rejected within 7 days	{1,2}	PENDING
2	2	2	SP002	{"width": "60cm", "length": "120cm", "material": "polyester"}	250000.00	60000.00	Refundable if defective	{3,4}	APPROVED
3	3	3	SP003	{"width": "40cm", "length": "90cm", "material": "silk"}	300000.00	70000.00	Non-refundable	{5,6}	REJECTED
\.


--
-- Data for Name: grn_items; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.grn_items (id, grn_id, po_item_id, qty_ordered, qty_received, diff, remarks, signer) FROM stdin;
1	1	1	100	100	0	Sản phẩm chất lượng tốt	1
2	1	2	200	190	10	Thiếu 10 sản phẩm	1
3	2	3	150	150	0	Sản phẩm đạt chất lượng	2
4	3	4	250	240	10	Thiếu 10 sản phẩm	3
\.


--
-- Data for Name: grns; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.grns (id, po_id, wh_id, grn_no, checked_by, checked_at) FROM stdin;
1	1	1	GRN12345	1	2023-06-06 00:00:00
2	2	2	GRN12346	2	2023-06-10 00:00:00
3	3	1	GRN12347	3	2023-06-13 00:00:00
\.


--
-- Data for Name: inbound_shipments; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.inbound_shipments (id, po_id, leg, ship_no, depart_at, arrive_est, arrive_actual, status) FROM stdin;
1	1	SUPPLIER→FWDR	SHIP12345	2023-06-02	2023-06-05	2023-06-06	PENDING
2	2	FWDR→VN	SHIP12346	2023-06-06	2023-06-09	2023-06-10	PENDING
3	3	SUPPLIER→FWDR	SHIP12347	2023-06-07	2023-06-12	2023-06-13	IN_TRANSIT
\.


--
-- Data for Name: po_items; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.po_items (id, po_id, product_variant_id, img_file_id, qty, unit_cost, amount) FROM stdin;
1	1	1	1	100	150000.00	15000000.00
2	1	2	2	200	120000.00	24000000.00
3	2	3	3	150	100000.00	15000000.00
4	3	1	4	250	180000.00	45000000.00
\.


--
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.purchase_orders (id, supplier_id, po_no, order_date, currency, status, ship_route, notes) FROM stdin;
1	1	PO12345	2023-06-01	VND	PENDING	{"VN": "Vietnam Warehouse", "NCC": "Supplier A", "FWDR": "Forwarder 1"}	Đơn hàng nhập khẩu từ nhà cung cấp A
2	2	PO12346	2023-06-05	VND	PENDING	{"VN": "Vietnam Warehouse", "NCC": "Supplier B", "FWDR": "Forwarder 2"}	Đơn hàng nhập khẩu từ nhà cung cấp B
3	3	PO12347	2023-06-10	VND	PENDING	{"VN": "Vietnam Warehouse", "NCC": "Supplier C", "FWDR": "Forwarder 3"}	Đơn hàng nhập khẩu từ nhà cung cấp C
\.


--
-- Data for Name: qc_checks; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.qc_checks (id, grn_item_id, result, photos, notes) FROM stdin;
1	1	PASS	{1,2}	Kiểm tra đạt yêu cầu
2	2	FAIL	{3}	Kiểm tra không đạt yêu cầu, thiếu 10 sản phẩm
3	3	PASS	{4}	Kiểm tra đạt yêu cầu
4	4	FAIL	{5}	Kiểm tra không đạt yêu cầu, thiếu 10 sản phẩm
\.


--
-- Data for Name: tag_sewing_batches; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.tag_sewing_batches (id, so_id, date_in, charge_user, signer) FROM stdin;
1	1	2023-06-07	1	1
2	2	2023-06-10	2	2
3	3	2023-06-13	3	3
\.


--
-- Data for Name: tag_sewing_items; Type: TABLE DATA; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

COPY mua_hang_nhap_kho_qc_tag.tag_sewing_items (id, batch_id, product_variant_id, qty) FROM stdin;
1	1	1	100
2	1	2	200
3	2	3	150
4	3	1	250
\.


--
-- Data for Name: supplier_contacts; Type: TABLE DATA; Schema: nha_cung_cap_soi; Owner: postgres
--

COPY nha_cung_cap_soi.supplier_contacts (id, supplier_id, contact_name, phone, wechat, notes) FROM stdin;
1	1	Nguyễn Văn A	0901234567	nguyenvana	Liên hệ với bộ phận bán hàng
2	1	Trần Thị B	0902345678	tranthib	Chăm sóc khách hàng
3	2	Lê Minh C	0903456789	leminhc	Giám đốc kinh doanh
4	3	Phạm Thị D	0904567890	phamthid	Hỗ trợ kỹ thuật
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: nha_cung_cap_soi; Owner: postgres
--

COPY nha_cung_cap_soi.suppliers (id, code, name, nickname, product_lines, current_ap_total_purchased) FROM stdin;
1	L006	Công ty Sợi ABC	Sợi ABC	["Sợi cotton", "Sợi polyester", "Sợi nilon"]	50000.00
2	L007	Công ty Sợi XYZ	Sợi XYZ	["Sợi viscose", "Sợi acrylic"]	30000.00
3	L008	Công ty Sợi LMN	Sợi LMN	["Sợi len", "Sợi polypropylene"]	70000.00
\.


--
-- Data for Name: yarn_color_cards; Type: TABLE DATA; Schema: nha_cung_cap_soi; Owner: postgres
--

COPY nha_cung_cap_soi.yarn_color_cards (id, yarn_id, card_type, id_img_file_id) FROM stdin;
1	1	Standard	1
2	2	Premium	2
3	3	Eco-Friendly	3
\.


--
-- Data for Name: yarn_colors; Type: TABLE DATA; Schema: nha_cung_cap_soi; Owner: postgres
--

COPY nha_cung_cap_soi.yarn_colors (id, yarn_card_id, color_name, color_no, remarks) FROM stdin;
1	1	Màu đỏ	R001	Đỏ tươi, phù hợp với mùa hè
2	1	Màu xanh	G001	Xanh lá cây, tươi mát, dễ dàng kết hợp
3	2	Màu vàng	Y001	Vàng ánh kim, phù hợp với thiết kế cao cấp
4	2	Màu đen	B001	Đen tuyền, thanh lịch và dễ phối hợp
5	3	Màu trắng	W001	Trắng tinh khiết, dễ nhuộm thêm màu
\.


--
-- Data for Name: yarns; Type: TABLE DATA; Schema: nha_cung_cap_soi; Owner: postgres
--

COPY nha_cung_cap_soi.yarns (id, supplier_id, blend_json, notes) FROM stdin;
1	1	{"poly": 35, "nylon": 40, "viscose": 25}	Sợi vải chất lượng cao, bền, phù hợp với nhu cầu may mặc
2	2	{"poly": 50, "viscose": 50}	Sợi mềm mại, dễ nhuộm màu, phù hợp với sản phẩm thời trang
3	3	{"polypropylene": 100}	Sợi siêu bền, chống cháy, sử dụng cho các sản phẩm kỹ thuật
\.


--
-- Data for Name: employee_roles; Type: TABLE DATA; Schema: nhan_su; Owner: postgres
--

COPY nhan_su.employee_roles (id, employee_id, role_id, department_id) FROM stdin;
1	1	1	1
2	2	2	2
3	3	3	3
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: nhan_su; Owner: postgres
--

COPY nhan_su.employees (id, name, dob, phone, address, tax_no, bank_info, joined_date, seniority_years, cv_file_id, total_salary_paid) FROM stdin;
1	Nguyễn Văn A	1990-01-01	0123456789	Hà Nội	123456789	{"bank_name": "Ngân hàng A", "account_no": "1234567890"}	2020-01-01	3	1	10000000.00
2	Trần Thị B	1985-05-15	0987654321	TP.HCM	987654321	{"bank_name": "Ngân hàng B", "account_no": "0987654321"}	2018-06-01	5	2	12000000.00
3	Phạm Minh C	1980-10-20	0912345678	Đà Nẵng	111223344	{"bank_name": "Ngân hàng C", "account_no": "1122334455"}	2015-11-01	8	3	15000000.00
\.


--
-- Data for Name: payroll_records; Type: TABLE DATA; Schema: nhan_su; Owner: postgres
--

COPY nhan_su.payroll_records (id, employee_id, month, gross, net, paid_at, notes) FROM stdin;
1	1	2023-06-01	12000000.00	10000000.00	2023-06-05	Lương tháng 6 cho Nguyễn Văn A
2	2	2023-06-01	14000000.00	12000000.00	2023-06-07	Lương tháng 6 cho Trần Thị B
3	3	2023-06-01	18000000.00	15000000.00	2023-06-10	Lương tháng 6 cho Phạm Minh C
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: san_pham; Owner: postgres
--

COPY san_pham.product_images (id, product_id, file_id, sort) FROM stdin;
\.


--
-- Data for Name: product_supplier_map; Type: TABLE DATA; Schema: san_pham; Owner: postgres
--

COPY san_pham.product_supplier_map (id, product_id, supplier_id, default_cost, currency, lead_time_days) FROM stdin;
1	1	1	150000.00	VND	30
2	2	2	250000.00	VND	45
3	3	3	400000.00	VND	60
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: san_pham; Owner: postgres
--

COPY san_pham.product_variants (id, product_id, sku, size, color, barcode) FROM stdin;
1	1	SKU001	L	Màu đỏ	1234567890
2	1	SKU002	M	Màu xanh	0987654321
3	2	SKU003	XL	Màu đen	1122334455
4	2	SKU004	S	Màu trắng	5566778899
5	3	SKU005	M	Màu hồng	2233445566
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: san_pham; Owner: postgres
--

COPY san_pham.products (id, supplier_item_code, our_code, name, category, fiber_spec, min_price, images, status) FROM stdin;
1	S001	P001	Áo thun nam	Top	{"yarn_id": 1}	200000.00	{1,2}	t
2	S002	P002	Quần jean nữ	Bottom	{"yarn_id": 2}	350000.00	{3,4}	t
3	S003	P003	Váy đầm công sở	Top	{"yarn_id": 3}	500000.00	{5,6}	t
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.activity_logs (id, object_type, object_id, action, by_user, at) FROM stdin;
1	product	1	create	1	2025-09-30 16:14:24.755837
2	yarn_color_card	1	update	2	2025-09-30 16:14:24.755837
3	invoice	1	delete	3	2025-09-30 16:14:24.755837
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.departments (id, name) FROM stdin;
1	Sale
2	Purchasing
3	Kế toán
4	Kho
5	BOD
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.files (id, object_type, object_id, file_path, caption, uploaded_by, created_at) FROM stdin;
1	product	1	/files/product1.jpg	Ảnh sản phẩm 1	1	2025-09-30 16:14:17.737384
2	yarn_color_card	1	/files/yarn_card1.jpg	Bảng màu sợi 1	2	2025-09-30 16:14:17.737384
3	invoice	1	/files/invoice123.pdf	Hóa đơn 123	3	2025-09-30 16:14:17.737384
4	product_image	1	/files/product_image_4.jpg	Ảnh sản phẩm 4	1	2025-10-01 00:58:05.380887
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.roles (id, name, permissions) FROM stdin;
1	Admin	{"read": true, "create": true, "delete": true, "update": true}
2	Sales	{"read": true, "create": true, "delete": false, "update": false}
3	Accounting	{"read": true, "create": true, "delete": false, "update": true}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.users (id, full_name, phone, email, role_id, status, password_hash) FROM stdin;
1	Nguyễn Văn A	0901234567	nguyenvana@example.com	1	t	$2b$10$jTjIxHmtvGo3VSNR5tK9juDeuw/V.LIV1R7B4wDncq/i3CKr1KI9q
2	Trần Thị B	0902345678	tranthib@example.com	2	t	$2b$10$jTjIxHmtvGo3VSNR5tK9juDeuw/V.LIV1R7B4wDncq/i3CKr1KI9q
3	Lê Minh C	0903456789	leminhc@example.com	3	f	$2b$10$jTjIxHmtvGo3VSNR5tK9juDeuw/V.LIV1R7B4wDncq/i3CKr1KI9q
4	Lê trần Chang	0903987654	letranchang@gmail.com	3	t	$2b$10$jTjIxHmtvGo3VSNR5tK9juDeuw/V.LIV1R7B4wDncq/i3CKr1KI9q
5	Lê Minh C	0903453289	linhchang@gmail.com	3	t	$2b$10$JDFubm1bnstJhiGcIWASYukpbkcrxnohtKnggcWzQlDD6cziLUE9a
6	phu sỹ	0966666689	lgg9@gmail.com	2	t	$2b$10$aDzq5B26iIMUSSqKP5yQLeTpgssatZ/VSgzX1pUscKVbz3m05AlNK
7	chủ hệ thống	0111111111	admin@gmail.com	1	t	$2b$10$QJftEg7stVVctKrssthI4u6nCOf4KezuCWPtMLgEvcSZ.allzO7Wa
\.


--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.warehouses (id, code, name, address) FROM stdin;
1	WH211B	Kho Hà Nội	Số 1, Đường Nguyễn Trãi, Hà Nội
2	WH168	Kho TP.HCM	Số 168, Đường Nguyễn Thị Minh Khai, TP.HCM
3	WH003	Kho Đà Nẵng	Số 3, Đường Phan Chu Trinh, Đà Nẵng
\.


--
-- Name: deliveries_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.deliveries_id_seq', 1, false);


--
-- Name: delivery_items_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.delivery_items_id_seq', 1, false);


--
-- Name: estimate_items_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.estimate_items_id_seq', 1, false);


--
-- Name: estimates_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.estimates_id_seq', 1, false);


--
-- Name: sales_order_items_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.sales_order_items_id_seq', 1, false);


--
-- Name: sales_orders_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.sales_orders_id_seq', 1, false);


--
-- Name: so_settlements_id_seq; Type: SEQUENCE SET; Schema: ban_hang; Owner: postgres
--

SELECT pg_catalog.setval('ban_hang.so_settlements_id_seq', 1, false);


--
-- Name: crm_leads_id_seq; Type: SEQUENCE SET; Schema: crm_khach_hang; Owner: postgres
--

SELECT pg_catalog.setval('crm_khach_hang.crm_leads_id_seq', 1, false);


--
-- Name: customer_banks_id_seq; Type: SEQUENCE SET; Schema: crm_khach_hang; Owner: postgres
--

SELECT pg_catalog.setval('crm_khach_hang.customer_banks_id_seq', 1, false);


--
-- Name: customer_interest_id_seq; Type: SEQUENCE SET; Schema: crm_khach_hang; Owner: postgres
--

SELECT pg_catalog.setval('crm_khach_hang.customer_interest_id_seq', 1, false);


--
-- Name: customer_price_history_id_seq; Type: SEQUENCE SET; Schema: crm_khach_hang; Owner: postgres
--

SELECT pg_catalog.setval('crm_khach_hang.customer_price_history_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: crm_khach_hang; Owner: postgres
--

SELECT pg_catalog.setval('crm_khach_hang.customers_id_seq', 1, false);


--
-- Name: ap_bills_id_seq; Type: SEQUENCE SET; Schema: ke_toan_tien; Owner: postgres
--

SELECT pg_catalog.setval('ke_toan_tien.ap_bills_id_seq', 1, false);


--
-- Name: ar_invoices_id_seq; Type: SEQUENCE SET; Schema: ke_toan_tien; Owner: postgres
--

SELECT pg_catalog.setval('ke_toan_tien.ar_invoices_id_seq', 1, false);


--
-- Name: balances_daily_id_seq; Type: SEQUENCE SET; Schema: ke_toan_tien; Owner: postgres
--

SELECT pg_catalog.setval('ke_toan_tien.balances_daily_id_seq', 1, false);


--
-- Name: bank_accounts_id_seq; Type: SEQUENCE SET; Schema: ke_toan_tien; Owner: postgres
--

SELECT pg_catalog.setval('ke_toan_tien.bank_accounts_id_seq', 1, false);


--
-- Name: cashbooks_id_seq; Type: SEQUENCE SET; Schema: ke_toan_tien; Owner: postgres
--

SELECT pg_catalog.setval('ke_toan_tien.cashbooks_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: ke_toan_tien; Owner: postgres
--

SELECT pg_catalog.setval('ke_toan_tien.payments_id_seq', 1, false);


--
-- Name: inventory_ledgers_id_seq; Type: SEQUENCE SET; Schema: kho_ton; Owner: postgres
--

SELECT pg_catalog.setval('kho_ton.inventory_ledgers_id_seq', 1, false);


--
-- Name: stock_transfer_items_id_seq; Type: SEQUENCE SET; Schema: kho_ton; Owner: postgres
--

SELECT pg_catalog.setval('kho_ton.stock_transfer_items_id_seq', 1, false);


--
-- Name: stock_transfers_id_seq; Type: SEQUENCE SET; Schema: kho_ton; Owner: postgres
--

SELECT pg_catalog.setval('kho_ton.stock_transfers_id_seq', 1, false);


--
-- Name: sample_changes_id_seq; Type: SEQUENCE SET; Schema: mau_custom; Owner: postgres
--

SELECT pg_catalog.setval('mau_custom.sample_changes_id_seq', 1, false);


--
-- Name: sample_outcome_id_seq; Type: SEQUENCE SET; Schema: mau_custom; Owner: postgres
--

SELECT pg_catalog.setval('mau_custom.sample_outcome_id_seq', 1, false);


--
-- Name: samples_id_seq; Type: SEQUENCE SET; Schema: mau_custom; Owner: postgres
--

SELECT pg_catalog.setval('mau_custom.samples_id_seq', 1, false);


--
-- Name: grn_items_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.grn_items_id_seq', 1, false);


--
-- Name: grns_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.grns_id_seq', 1, false);


--
-- Name: inbound_shipments_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.inbound_shipments_id_seq', 1, false);


--
-- Name: po_items_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.po_items_id_seq', 1, false);


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.purchase_orders_id_seq', 1, false);


--
-- Name: qc_checks_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.qc_checks_id_seq', 1, false);


--
-- Name: tag_sewing_batches_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.tag_sewing_batches_id_seq', 1, false);


--
-- Name: tag_sewing_items_id_seq; Type: SEQUENCE SET; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

SELECT pg_catalog.setval('mua_hang_nhap_kho_qc_tag.tag_sewing_items_id_seq', 1, false);


--
-- Name: supplier_contacts_id_seq; Type: SEQUENCE SET; Schema: nha_cung_cap_soi; Owner: postgres
--

SELECT pg_catalog.setval('nha_cung_cap_soi.supplier_contacts_id_seq', 1, false);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: nha_cung_cap_soi; Owner: postgres
--

SELECT pg_catalog.setval('nha_cung_cap_soi.suppliers_id_seq', 1, false);


--
-- Name: yarn_color_cards_id_seq; Type: SEQUENCE SET; Schema: nha_cung_cap_soi; Owner: postgres
--

SELECT pg_catalog.setval('nha_cung_cap_soi.yarn_color_cards_id_seq', 1, false);


--
-- Name: yarn_colors_id_seq; Type: SEQUENCE SET; Schema: nha_cung_cap_soi; Owner: postgres
--

SELECT pg_catalog.setval('nha_cung_cap_soi.yarn_colors_id_seq', 1, false);


--
-- Name: yarns_id_seq; Type: SEQUENCE SET; Schema: nha_cung_cap_soi; Owner: postgres
--

SELECT pg_catalog.setval('nha_cung_cap_soi.yarns_id_seq', 1, false);


--
-- Name: employee_roles_id_seq; Type: SEQUENCE SET; Schema: nhan_su; Owner: postgres
--

SELECT pg_catalog.setval('nhan_su.employee_roles_id_seq', 1, false);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: nhan_su; Owner: postgres
--

SELECT pg_catalog.setval('nhan_su.employees_id_seq', 1, false);


--
-- Name: payroll_records_id_seq; Type: SEQUENCE SET; Schema: nhan_su; Owner: postgres
--

SELECT pg_catalog.setval('nhan_su.payroll_records_id_seq', 1, false);


--
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: san_pham; Owner: postgres
--

SELECT pg_catalog.setval('san_pham.product_images_id_seq', 1, false);


--
-- Name: product_supplier_map_id_seq; Type: SEQUENCE SET; Schema: san_pham; Owner: postgres
--

SELECT pg_catalog.setval('san_pham.product_supplier_map_id_seq', 1, false);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: san_pham; Owner: postgres
--

SELECT pg_catalog.setval('san_pham.product_variants_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: san_pham; Owner: postgres
--

SELECT pg_catalog.setval('san_pham.products_id_seq', 1, false);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.activity_logs_id_seq', 1, false);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.departments_id_seq', 1, false);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.files_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.roles_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.users_id_seq', 7, true);


--
-- Name: warehouses_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.warehouses_id_seq', 1, false);


--
-- Name: deliveries deliveries_delivery_no_key; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.deliveries
    ADD CONSTRAINT deliveries_delivery_no_key UNIQUE (delivery_no);


--
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- Name: delivery_items delivery_items_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.delivery_items
    ADD CONSTRAINT delivery_items_pkey PRIMARY KEY (id);


--
-- Name: estimate_items estimate_items_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimate_items
    ADD CONSTRAINT estimate_items_pkey PRIMARY KEY (id);


--
-- Name: estimates estimates_est_no_key; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimates
    ADD CONSTRAINT estimates_est_no_key UNIQUE (est_no);


--
-- Name: estimates estimates_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimates
    ADD CONSTRAINT estimates_pkey PRIMARY KEY (id);


--
-- Name: sales_order_items sales_order_items_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_order_items
    ADD CONSTRAINT sales_order_items_pkey PRIMARY KEY (id);


--
-- Name: sales_orders sales_orders_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_orders
    ADD CONSTRAINT sales_orders_pkey PRIMARY KEY (id);


--
-- Name: sales_orders sales_orders_so_no_key; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_orders
    ADD CONSTRAINT sales_orders_so_no_key UNIQUE (so_no);


--
-- Name: so_settlements so_settlements_pkey; Type: CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.so_settlements
    ADD CONSTRAINT so_settlements_pkey PRIMARY KEY (id);


--
-- Name: crm_leads crm_leads_pkey; Type: CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.crm_leads
    ADD CONSTRAINT crm_leads_pkey PRIMARY KEY (id);


--
-- Name: customer_banks customer_banks_pkey; Type: CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_banks
    ADD CONSTRAINT customer_banks_pkey PRIMARY KEY (id);


--
-- Name: customer_interest customer_interest_pkey; Type: CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_interest
    ADD CONSTRAINT customer_interest_pkey PRIMARY KEY (id);


--
-- Name: customer_price_history customer_price_history_pkey; Type: CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_price_history
    ADD CONSTRAINT customer_price_history_pkey PRIMARY KEY (id);


--
-- Name: customers customers_code_key; Type: CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customers
    ADD CONSTRAINT customers_code_key UNIQUE (code);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: ap_bills ap_bills_bill_no_key; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ap_bills
    ADD CONSTRAINT ap_bills_bill_no_key UNIQUE (bill_no);


--
-- Name: ap_bills ap_bills_pkey; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ap_bills
    ADD CONSTRAINT ap_bills_pkey PRIMARY KEY (id);


--
-- Name: ar_invoices ar_invoices_invoice_no_key; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ar_invoices
    ADD CONSTRAINT ar_invoices_invoice_no_key UNIQUE (invoice_no);


--
-- Name: ar_invoices ar_invoices_pkey; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ar_invoices
    ADD CONSTRAINT ar_invoices_pkey PRIMARY KEY (id);


--
-- Name: balances_daily balances_daily_pkey; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.balances_daily
    ADD CONSTRAINT balances_daily_pkey PRIMARY KEY (id);


--
-- Name: bank_accounts bank_accounts_account_no_key; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.bank_accounts
    ADD CONSTRAINT bank_accounts_account_no_key UNIQUE (account_no);


--
-- Name: bank_accounts bank_accounts_pkey; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.bank_accounts
    ADD CONSTRAINT bank_accounts_pkey PRIMARY KEY (id);


--
-- Name: cashbooks cashbooks_pkey; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks
    ADD CONSTRAINT cashbooks_pkey PRIMARY KEY (id);


--
-- Name: cashbooks cashbooks_tx_no_key; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks
    ADD CONSTRAINT cashbooks_tx_no_key UNIQUE (tx_no);


--
-- Name: payments payments_pay_no_key; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.payments
    ADD CONSTRAINT payments_pay_no_key UNIQUE (pay_no);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: inventory_ledgers inventory_ledgers_pkey; Type: CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.inventory_ledgers
    ADD CONSTRAINT inventory_ledgers_pkey PRIMARY KEY (id);


--
-- Name: stock_transfer_items stock_transfer_items_pkey; Type: CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_pkey PRIMARY KEY (id);


--
-- Name: stock_transfers stock_transfers_pkey; Type: CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfers
    ADD CONSTRAINT stock_transfers_pkey PRIMARY KEY (id);


--
-- Name: stock_transfers stock_transfers_transfer_no_key; Type: CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfers
    ADD CONSTRAINT stock_transfers_transfer_no_key UNIQUE (transfer_no);


--
-- Name: sample_changes sample_changes_pkey; Type: CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.sample_changes
    ADD CONSTRAINT sample_changes_pkey PRIMARY KEY (id);


--
-- Name: sample_outcome sample_outcome_pkey; Type: CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.sample_outcome
    ADD CONSTRAINT sample_outcome_pkey PRIMARY KEY (id);


--
-- Name: samples samples_pkey; Type: CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.samples
    ADD CONSTRAINT samples_pkey PRIMARY KEY (id);


--
-- Name: grn_items grn_items_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grn_items
    ADD CONSTRAINT grn_items_pkey PRIMARY KEY (id);


--
-- Name: grns grns_grn_no_key; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grns
    ADD CONSTRAINT grns_grn_no_key UNIQUE (grn_no);


--
-- Name: grns grns_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grns
    ADD CONSTRAINT grns_pkey PRIMARY KEY (id);


--
-- Name: inbound_shipments inbound_shipments_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.inbound_shipments
    ADD CONSTRAINT inbound_shipments_pkey PRIMARY KEY (id);


--
-- Name: po_items po_items_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.po_items
    ADD CONSTRAINT po_items_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders purchase_orders_po_no_key; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.purchase_orders
    ADD CONSTRAINT purchase_orders_po_no_key UNIQUE (po_no);


--
-- Name: qc_checks qc_checks_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.qc_checks
    ADD CONSTRAINT qc_checks_pkey PRIMARY KEY (id);


--
-- Name: tag_sewing_batches tag_sewing_batches_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_batches
    ADD CONSTRAINT tag_sewing_batches_pkey PRIMARY KEY (id);


--
-- Name: tag_sewing_items tag_sewing_items_pkey; Type: CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_items
    ADD CONSTRAINT tag_sewing_items_pkey PRIMARY KEY (id);


--
-- Name: supplier_contacts supplier_contacts_pkey; Type: CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.supplier_contacts
    ADD CONSTRAINT supplier_contacts_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_code_key; Type: CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.suppliers
    ADD CONSTRAINT suppliers_code_key UNIQUE (code);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: yarn_color_cards yarn_color_cards_pkey; Type: CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_color_cards
    ADD CONSTRAINT yarn_color_cards_pkey PRIMARY KEY (id);


--
-- Name: yarn_colors yarn_colors_pkey; Type: CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_colors
    ADD CONSTRAINT yarn_colors_pkey PRIMARY KEY (id);


--
-- Name: yarns yarns_pkey; Type: CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarns
    ADD CONSTRAINT yarns_pkey PRIMARY KEY (id);


--
-- Name: employee_roles employee_roles_pkey; Type: CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employee_roles
    ADD CONSTRAINT employee_roles_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: payroll_records payroll_records_pkey; Type: CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.payroll_records
    ADD CONSTRAINT payroll_records_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: product_supplier_map product_supplier_map_pkey; Type: CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_supplier_map
    ADD CONSTRAINT product_supplier_map_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_sku_key; Type: CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_variants
    ADD CONSTRAINT product_variants_sku_key UNIQUE (sku);


--
-- Name: products products_our_code_key; Type: CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.products
    ADD CONSTRAINT products_our_code_key UNIQUE (our_code);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warehouses warehouses_code_key; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.warehouses
    ADD CONSTRAINT warehouses_code_key UNIQUE (code);


--
-- Name: warehouses warehouses_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (id);


--
-- Name: deliveries deliveries_so_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.deliveries
    ADD CONSTRAINT deliveries_so_id_fkey FOREIGN KEY (so_id) REFERENCES ban_hang.sales_orders(id);


--
-- Name: deliveries deliveries_wh_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.deliveries
    ADD CONSTRAINT deliveries_wh_id_fkey FOREIGN KEY (wh_id) REFERENCES system.warehouses(id);


--
-- Name: delivery_items delivery_items_delivery_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.delivery_items
    ADD CONSTRAINT delivery_items_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES ban_hang.deliveries(id);


--
-- Name: delivery_items delivery_items_so_item_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.delivery_items
    ADD CONSTRAINT delivery_items_so_item_id_fkey FOREIGN KEY (so_item_id) REFERENCES ban_hang.sales_order_items(id);


--
-- Name: estimate_items estimate_items_estimate_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimate_items
    ADD CONSTRAINT estimate_items_estimate_id_fkey FOREIGN KEY (estimate_id) REFERENCES ban_hang.estimates(id);


--
-- Name: estimate_items estimate_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimate_items
    ADD CONSTRAINT estimate_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES san_pham.product_variants(id);


--
-- Name: estimates estimates_customer_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.estimates
    ADD CONSTRAINT estimates_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: sales_order_items sales_order_items_image_file_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_order_items
    ADD CONSTRAINT sales_order_items_image_file_id_fkey FOREIGN KEY (image_file_id) REFERENCES system.files(id);


--
-- Name: sales_order_items sales_order_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_order_items
    ADD CONSTRAINT sales_order_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES san_pham.product_variants(id);


--
-- Name: sales_order_items sales_order_items_so_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_order_items
    ADD CONSTRAINT sales_order_items_so_id_fkey FOREIGN KEY (so_id) REFERENCES ban_hang.sales_orders(id);


--
-- Name: sales_orders sales_orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_orders
    ADD CONSTRAINT sales_orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: sales_orders sales_orders_from_estimate_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.sales_orders
    ADD CONSTRAINT sales_orders_from_estimate_id_fkey FOREIGN KEY (from_estimate_id) REFERENCES ban_hang.estimates(id);


--
-- Name: so_settlements so_settlements_so_id_fkey; Type: FK CONSTRAINT; Schema: ban_hang; Owner: postgres
--

ALTER TABLE ONLY ban_hang.so_settlements
    ADD CONSTRAINT so_settlements_so_id_fkey FOREIGN KEY (so_id) REFERENCES ban_hang.sales_orders(id);


--
-- Name: crm_leads crm_leads_customer_id_fkey; Type: FK CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.crm_leads
    ADD CONSTRAINT crm_leads_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: customer_banks customer_banks_customer_id_fkey; Type: FK CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_banks
    ADD CONSTRAINT customer_banks_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: customer_banks customer_banks_qr_file_id_fkey; Type: FK CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_banks
    ADD CONSTRAINT customer_banks_qr_file_id_fkey FOREIGN KEY (qr_file_id) REFERENCES system.files(id);


--
-- Name: customer_interest customer_interest_customer_id_fkey; Type: FK CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_interest
    ADD CONSTRAINT customer_interest_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: customer_price_history customer_price_history_customer_id_fkey; Type: FK CONSTRAINT; Schema: crm_khach_hang; Owner: postgres
--

ALTER TABLE ONLY crm_khach_hang.customer_price_history
    ADD CONSTRAINT customer_price_history_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: ap_bills ap_bills_po_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ap_bills
    ADD CONSTRAINT ap_bills_po_id_fkey FOREIGN KEY (po_id) REFERENCES mua_hang_nhap_kho_qc_tag.purchase_orders(id);


--
-- Name: ar_invoices ar_invoices_so_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.ar_invoices
    ADD CONSTRAINT ar_invoices_so_id_fkey FOREIGN KEY (so_id) REFERENCES ban_hang.sales_orders(id);


--
-- Name: balances_daily balances_daily_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.balances_daily
    ADD CONSTRAINT balances_daily_bank_account_id_fkey FOREIGN KEY (bank_account_id) REFERENCES ke_toan_tien.bank_accounts(id);


--
-- Name: bank_accounts bank_accounts_qr_file_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.bank_accounts
    ADD CONSTRAINT bank_accounts_qr_file_id_fkey FOREIGN KEY (qr_file_id) REFERENCES system.files(id);


--
-- Name: cashbooks cashbooks_account_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks
    ADD CONSTRAINT cashbooks_account_id_fkey FOREIGN KEY (account_id) REFERENCES ke_toan_tien.bank_accounts(id);


--
-- Name: cashbooks cashbooks_created_by_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks
    ADD CONSTRAINT cashbooks_created_by_fkey FOREIGN KEY (created_by) REFERENCES system.users(id);


--
-- Name: cashbooks cashbooks_po_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks
    ADD CONSTRAINT cashbooks_po_id_fkey FOREIGN KEY (po_id) REFERENCES mua_hang_nhap_kho_qc_tag.purchase_orders(id) ON DELETE SET NULL;


--
-- Name: cashbooks cashbooks_so_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.cashbooks
    ADD CONSTRAINT cashbooks_so_id_fkey FOREIGN KEY (so_id) REFERENCES ban_hang.sales_orders(id) ON DELETE SET NULL;


--
-- Name: payments payments_from_account_id_fkey; Type: FK CONSTRAINT; Schema: ke_toan_tien; Owner: postgres
--

ALTER TABLE ONLY ke_toan_tien.payments
    ADD CONSTRAINT payments_from_account_id_fkey FOREIGN KEY (from_account_id) REFERENCES ke_toan_tien.bank_accounts(id);


--
-- Name: inventory_ledgers inventory_ledgers_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.inventory_ledgers
    ADD CONSTRAINT inventory_ledgers_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES san_pham.product_variants(id);


--
-- Name: inventory_ledgers inventory_ledgers_wh_id_fkey; Type: FK CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.inventory_ledgers
    ADD CONSTRAINT inventory_ledgers_wh_id_fkey FOREIGN KEY (wh_id) REFERENCES system.warehouses(id);


--
-- Name: stock_transfer_items stock_transfer_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES san_pham.product_variants(id);


--
-- Name: stock_transfer_items stock_transfer_items_transfer_id_fkey; Type: FK CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_transfer_id_fkey FOREIGN KEY (transfer_id) REFERENCES kho_ton.stock_transfers(id);


--
-- Name: stock_transfers stock_transfers_from_wh_id_fkey; Type: FK CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfers
    ADD CONSTRAINT stock_transfers_from_wh_id_fkey FOREIGN KEY (from_wh_id) REFERENCES system.warehouses(id);


--
-- Name: stock_transfers stock_transfers_to_wh_id_fkey; Type: FK CONSTRAINT; Schema: kho_ton; Owner: postgres
--

ALTER TABLE ONLY kho_ton.stock_transfers
    ADD CONSTRAINT stock_transfers_to_wh_id_fkey FOREIGN KEY (to_wh_id) REFERENCES system.warehouses(id);


--
-- Name: sample_changes sample_changes_sample_id_fkey; Type: FK CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.sample_changes
    ADD CONSTRAINT sample_changes_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES mau_custom.samples(id);


--
-- Name: sample_outcome sample_outcome_sample_id_fkey; Type: FK CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.sample_outcome
    ADD CONSTRAINT sample_outcome_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES mau_custom.samples(id);


--
-- Name: samples samples_customer_id_fkey; Type: FK CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.samples
    ADD CONSTRAINT samples_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES crm_khach_hang.customers(id);


--
-- Name: samples samples_supplier_id_fkey; Type: FK CONSTRAINT; Schema: mau_custom; Owner: postgres
--

ALTER TABLE ONLY mau_custom.samples
    ADD CONSTRAINT samples_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES nha_cung_cap_soi.suppliers(id);


--
-- Name: grn_items grn_items_grn_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grn_items
    ADD CONSTRAINT grn_items_grn_id_fkey FOREIGN KEY (grn_id) REFERENCES mua_hang_nhap_kho_qc_tag.grns(id);


--
-- Name: grn_items grn_items_po_item_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grn_items
    ADD CONSTRAINT grn_items_po_item_id_fkey FOREIGN KEY (po_item_id) REFERENCES mua_hang_nhap_kho_qc_tag.po_items(id);


--
-- Name: grn_items grn_items_signer_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grn_items
    ADD CONSTRAINT grn_items_signer_fkey FOREIGN KEY (signer) REFERENCES system.users(id);


--
-- Name: grns grns_checked_by_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grns
    ADD CONSTRAINT grns_checked_by_fkey FOREIGN KEY (checked_by) REFERENCES system.users(id);


--
-- Name: grns grns_po_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grns
    ADD CONSTRAINT grns_po_id_fkey FOREIGN KEY (po_id) REFERENCES mua_hang_nhap_kho_qc_tag.purchase_orders(id);


--
-- Name: grns grns_wh_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.grns
    ADD CONSTRAINT grns_wh_id_fkey FOREIGN KEY (wh_id) REFERENCES system.warehouses(id);


--
-- Name: inbound_shipments inbound_shipments_po_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.inbound_shipments
    ADD CONSTRAINT inbound_shipments_po_id_fkey FOREIGN KEY (po_id) REFERENCES mua_hang_nhap_kho_qc_tag.purchase_orders(id);


--
-- Name: po_items po_items_img_file_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.po_items
    ADD CONSTRAINT po_items_img_file_id_fkey FOREIGN KEY (img_file_id) REFERENCES system.files(id);


--
-- Name: po_items po_items_po_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.po_items
    ADD CONSTRAINT po_items_po_id_fkey FOREIGN KEY (po_id) REFERENCES mua_hang_nhap_kho_qc_tag.purchase_orders(id);


--
-- Name: po_items po_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.po_items
    ADD CONSTRAINT po_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES san_pham.product_variants(id);


--
-- Name: purchase_orders purchase_orders_supplier_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.purchase_orders
    ADD CONSTRAINT purchase_orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES nha_cung_cap_soi.suppliers(id);


--
-- Name: qc_checks qc_checks_grn_item_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.qc_checks
    ADD CONSTRAINT qc_checks_grn_item_id_fkey FOREIGN KEY (grn_item_id) REFERENCES mua_hang_nhap_kho_qc_tag.grn_items(id);


--
-- Name: tag_sewing_batches tag_sewing_batches_charge_user_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_batches
    ADD CONSTRAINT tag_sewing_batches_charge_user_fkey FOREIGN KEY (charge_user) REFERENCES system.users(id);


--
-- Name: tag_sewing_batches tag_sewing_batches_signer_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_batches
    ADD CONSTRAINT tag_sewing_batches_signer_fkey FOREIGN KEY (signer) REFERENCES system.users(id);


--
-- Name: tag_sewing_batches tag_sewing_batches_so_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_batches
    ADD CONSTRAINT tag_sewing_batches_so_id_fkey FOREIGN KEY (so_id) REFERENCES ban_hang.sales_orders(id);


--
-- Name: tag_sewing_items tag_sewing_items_batch_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_items
    ADD CONSTRAINT tag_sewing_items_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES mua_hang_nhap_kho_qc_tag.tag_sewing_batches(id);


--
-- Name: tag_sewing_items tag_sewing_items_product_variant_id_fkey; Type: FK CONSTRAINT; Schema: mua_hang_nhap_kho_qc_tag; Owner: postgres
--

ALTER TABLE ONLY mua_hang_nhap_kho_qc_tag.tag_sewing_items
    ADD CONSTRAINT tag_sewing_items_product_variant_id_fkey FOREIGN KEY (product_variant_id) REFERENCES san_pham.product_variants(id);


--
-- Name: supplier_contacts supplier_contacts_supplier_id_fkey; Type: FK CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.supplier_contacts
    ADD CONSTRAINT supplier_contacts_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES nha_cung_cap_soi.suppliers(id);


--
-- Name: yarn_color_cards yarn_color_cards_id_img_file_id_fkey; Type: FK CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_color_cards
    ADD CONSTRAINT yarn_color_cards_id_img_file_id_fkey FOREIGN KEY (id_img_file_id) REFERENCES system.files(id);


--
-- Name: yarn_color_cards yarn_color_cards_yarn_id_fkey; Type: FK CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_color_cards
    ADD CONSTRAINT yarn_color_cards_yarn_id_fkey FOREIGN KEY (yarn_id) REFERENCES nha_cung_cap_soi.yarns(id);


--
-- Name: yarn_colors yarn_colors_yarn_card_id_fkey; Type: FK CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarn_colors
    ADD CONSTRAINT yarn_colors_yarn_card_id_fkey FOREIGN KEY (yarn_card_id) REFERENCES nha_cung_cap_soi.yarn_color_cards(id);


--
-- Name: yarns yarns_supplier_id_fkey; Type: FK CONSTRAINT; Schema: nha_cung_cap_soi; Owner: postgres
--

ALTER TABLE ONLY nha_cung_cap_soi.yarns
    ADD CONSTRAINT yarns_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES nha_cung_cap_soi.suppliers(id);


--
-- Name: employee_roles employee_roles_department_id_fkey; Type: FK CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employee_roles
    ADD CONSTRAINT employee_roles_department_id_fkey FOREIGN KEY (department_id) REFERENCES system.departments(id);


--
-- Name: employee_roles employee_roles_employee_id_fkey; Type: FK CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employee_roles
    ADD CONSTRAINT employee_roles_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES nhan_su.employees(id);


--
-- Name: employee_roles employee_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employee_roles
    ADD CONSTRAINT employee_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES system.roles(id);


--
-- Name: employees employees_cv_file_id_fkey; Type: FK CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.employees
    ADD CONSTRAINT employees_cv_file_id_fkey FOREIGN KEY (cv_file_id) REFERENCES system.files(id);


--
-- Name: payroll_records payroll_records_employee_id_fkey; Type: FK CONSTRAINT; Schema: nhan_su; Owner: postgres
--

ALTER TABLE ONLY nhan_su.payroll_records
    ADD CONSTRAINT payroll_records_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES nhan_su.employees(id);


--
-- Name: product_images product_images_file_id_fkey; Type: FK CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_images
    ADD CONSTRAINT product_images_file_id_fkey FOREIGN KEY (file_id) REFERENCES system.files(id);


--
-- Name: product_images product_images_product_id_fkey; Type: FK CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES san_pham.products(id);


--
-- Name: product_supplier_map product_supplier_map_product_id_fkey; Type: FK CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_supplier_map
    ADD CONSTRAINT product_supplier_map_product_id_fkey FOREIGN KEY (product_id) REFERENCES san_pham.products(id);


--
-- Name: product_supplier_map product_supplier_map_supplier_id_fkey; Type: FK CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_supplier_map
    ADD CONSTRAINT product_supplier_map_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES nha_cung_cap_soi.suppliers(id);


--
-- Name: product_variants product_variants_product_id_fkey; Type: FK CONSTRAINT; Schema: san_pham; Owner: postgres
--

ALTER TABLE ONLY san_pham.product_variants
    ADD CONSTRAINT product_variants_product_id_fkey FOREIGN KEY (product_id) REFERENCES san_pham.products(id);


--
-- Name: activity_logs activity_logs_by_user_fkey; Type: FK CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.activity_logs
    ADD CONSTRAINT activity_logs_by_user_fkey FOREIGN KEY (by_user) REFERENCES system.users(id);


--
-- Name: files files_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.files
    ADD CONSTRAINT files_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES system.users(id);


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES system.roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict LIbEaQaYR8y9SIOzmRNLKTzK8wURbsYryCmsbXfSOoCoFrYXVgtHUskLnsFSglW

