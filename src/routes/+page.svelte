<script lang="ts">
    import { goto } from "$app/navigation";
    import {
        BarcodeFormat,
        DecodeHintType,
        BrowserMultiFormatReader,
        NotFoundException,
    } from "@zxing/library";
    import { onMount } from "svelte";
    const hints = new Map();
    const formats = [
        BarcodeFormat.QR_CODE,
        BarcodeFormat.DATA_MATRIX /*, ...*/,
    ];

    hints.set(DecodeHintType.POSSIBLE_FORMATS, formats);

    let reader: BrowserMultiFormatReader;
    let currentVideoDevice: string | null = null;
    let content: HTMLElement;
    // const luminanceSource = new RGBLuminanceSource(
    //     imgByteArray,
    //     imgWidth,
    //     imgHeight,
    // );
    // const binaryBitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));

    // reader.decode(binaryBitmap, hints);

    function onDecode(result: any, err: any) {
        if (result) {
            console.log(result);
            content.textContent = result.getText();
            goto("/search?code=" + result.getText());
        }

        if (err && !(err instanceof NotFoundException)) {
            console.error(err);
            content.textContent = err.message;
        }
    }

    function decodeFromDevice(deviceID: string) {
        reader.decodeFromVideoDevice(deviceID, "video", onDecode);
    }

    let listOFCamera: { deviceName: string; deviceID: string }[] = [];

    async function initCapture() {
        listOFCamera = [];
        reader = new BrowserMultiFormatReader();
        await reader.listVideoInputDevices().then((videoInputDevices) => {
            videoInputDevices.forEach((device) => {
                console.log(device.label);
                listOFCamera = [
                    ...listOFCamera,
                    { deviceName: device.label, deviceID: device.deviceId },
                ];
            });
        });
        showVideo = true;
    }

    onMount(() => {
        console.log("mounted");
    });

    let showVideo = false;

    let productName = "";
</script>

<svelte:head>
    <title>Comparez les prix de vos produits favoris</title>
</svelte:head>

<div class="md:mx-52 mt-4">
    <div class="flex flex-col items-center space-y-4 mb-4">
        <label class="w-full input input-bordered flex items-center gap-2">
            <input
                bind:value={productName}
                autocomplete="on"
                type="text"
                class="grow"
                placeholder="Rechercher le produit par son nom"
            />
            <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 16 16"
                fill="currentColor"
                class="w-4 h-4 opacity-70"
                ><path
                    fill-rule="evenodd"
                    d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
                    clip-rule="evenodd"
                /></svg
            >
        </label>
        <a class="btn w-3/4" href="/search?s={productName}"> Rechercher</a>
        <span class="hidden" bind:this={content}>Hello</span>
    </div>

    <div class="divider">OU EN SCANNANT SON CODE BARRE</div>

    {#key listOFCamera}
        <select class="select w-full mt-10 mb-4" name="camera" id="camera">
            {#each listOFCamera as camera}
                <option
                    on:click={() => {
                        console.log(
                            "switched current video device: ",
                            camera.deviceName,
                        );
                        currentVideoDevice = camera.deviceID;
                        decodeFromDevice(camera.deviceID);
                    }}
                    value={camera.deviceID}>{camera.deviceName}</option
                >
            {/each}
        </select>
    {/key}

    <div
        style="height: 70vh"
        class="flex bg-gray-400 w-full rounded-lg items-center justify-center"
    >
        {#if !showVideo}
            <button
                class="btn"
                on:click={async () => {
                    await initCapture();
                    decodeFromDevice(listOFCamera[0].deviceID);
                }}
            >
                Lancer le scan
            </button>
        {:else}
            {#key currentVideoDevice}
                <!-- svelte-ignore a11y-media-has-caption -->
                <video
                    id="video"
                    class="w-full h-full"
                    style="border: 1px solid gray"
                ></video>
            {/key}
        {/if}
    </div>
</div>
